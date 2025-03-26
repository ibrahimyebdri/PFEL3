"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@supabase/supabase-js";
import HeaderAdminA from "@/components/HeaderAdminA";
import Footer from "@/components/Footer";

// Initialisation de Supabase
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

const initialFormState = {
  name: "",
  description: "",
  price: 0,
  discount_percentage: null,
  start_date: "",
  end_date: "",
  difficulty_level: "moderate",
  duration: "",
  what_to_bring: "",
  meeting_point: "",
  images: null,
  max_participants: 10,
  language: "Français",
  is_guided: false,
  location: "",
  is_available: true,
};

export default function ActivitiesManager() {
  const router = useRouter();
  const [viewMode, setViewMode] = useState("list");
  const [activities, setActivities] = useState([]);
  const [editingActivity, setEditingActivity] = useState(null);
  const [formData, setFormData] = useState(initialFormState);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  useEffect(() => {
    const checkPermissions = async () => {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) return router.push("/auth");

      const { data, error } = await supabase
        .from("users")
        .select("role")
        .eq("user_id", user.id)
        .single();

      if (error || data?.role !== "tour_organizer") router.push("/");
      else fetchActivities();
    };

    checkPermissions();
  }, [router]);

  const fetchActivities = async () => {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) throw new Error("Authentification requise");

      const { data, error } = await supabase
        .from("tour_announcements")
        .select("*")
        .eq("user_id", user.id)
        .order("start_date", { ascending: false });

      if (error) throw error;
      setActivities(data || []);
    } catch (err) {
      setError(err.message || "Erreur de chargement des activités");
      console.error("fetchActivities error:", err);
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const uploadImage = async (file) => {
    if (!file) return null;
    const fileExt = file.name.split(".").pop();
    const fileName = `${formData.name}-${Date.now()}.${fileExt}`;
    const filePath = `tours/${fileName}`;

    const { error } = await supabase.storage
      .from("tour_photos")
      .upload(filePath, file);

    if (error) {
      console.error("Upload error:", error);
      throw new Error("Échec de l'upload de l'image");
    }

    return `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/tour_photos/${filePath}`;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    setSuccess("");

    try {
      if (!formData.name || !formData.price || !formData.start_date || !formData.end_date) {
        throw new Error("Veuillez remplir tous les champs obligatoires (*)");
      }

      const { data: { user }, error: authError } = await supabase.auth.getUser();
      if (authError || !user) throw new Error("Utilisateur non connecté");

      const numericData = {
        price: parseFloat(formData.price),
        discount_percentage: formData.discount_percentage
          ? Math.min(100, Math.max(0, parseFloat(formData.discount_percentage)))
          : null,
        max_participants: Math.max(1, parseInt(formData.max_participants) || 10),
      };

      let imageUrl = formData.images;
      if (formData.images instanceof File) {
        imageUrl = await uploadImage(formData.images);
      }

      const { new_price, ...formDataWithoutNewPrice } = formData;
      const activityData = {
        ...formDataWithoutNewPrice,
        ...numericData,
        images: imageUrl,
        user_id: user.id,
        is_available: !!formData.is_available,
        is_guided: !!formData.is_guided,
      };

      const { data, error: dbError } = editingActivity
        ? await supabase
            .from("tour_announcements")
            .update(activityData)
            .eq("tour_announcement_id", editingActivity.tour_announcement_id)
            .select()
        : await supabase
            .from("tour_announcements")
            .insert([activityData])
            .select();

      if (dbError) throw new Error(`Erreur base de données: ${dbError.message}`);

      setSuccess(editingActivity ? "Activité mise à jour avec succès !" : "Activité créée avec succès !");
      fetchActivities();
      setViewMode("list");
      setFormData(initialFormState);
      setEditingActivity(null);
    } catch (err) {
      setError(err.message || "Une erreur est survenue");
      console.error("Submit error:", err);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (!confirm("Êtes-vous sûr de vouloir supprimer cette activité ?")) return;

    setLoading(true);
    try {
      const { error } = await supabase
        .from("tour_announcements")
        .delete()
        .eq("tour_announcement_id", id);

      if (error) throw error;
      setSuccess("Activité supprimée avec succès !");
      fetchActivities();
    } catch (err) {
      setError(err.message);
      console.error("Delete error:", err);
    } finally {
      setLoading(false);
    }
  };

  const setupEdit = (activity) => {
    if (!activity) return;
    setEditingActivity(activity);
    setFormData({ ...initialFormState, ...activity });
    setViewMode("form");
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <HeaderAdminA />
      <main className="max-w-6xl mx-auto px-4 py-8">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-3xl font-bold text-blue-800">Gestion des Activités</h1>
          <button
            onClick={() => {
              setViewMode((v) => (v === "list" ? "form" : "list"));
              setEditingActivity(null);
              setFormData(initialFormState);
            }}
            className="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition-all duration-300 shadow-md"
          >
            {viewMode === "list" ? "Nouvelle activité +" : "Retour à la liste"}
          </button>
        </div>

        {error && (
          <div className="p-4 mb-6 bg-red-50 text-red-600 rounded-lg border border-red-200 shadow-sm">{error}</div>
        )}
        {success && (
          <div className="p-4 mb-6 bg-blue-50 text-blue-600 rounded-lg border border-blue-200 shadow-sm">{success}</div>
        )}

        {viewMode === "list" ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {activities.map((activity) => (
              <ActivityCard
                key={activity.tour_announcement_id}
                activity={activity}
                onEdit={setupEdit}
                onDelete={handleDelete}
              />
            ))}
          </div>
        ) : (
          <ActivityForm
            formData={formData}
            isEditing={!!editingActivity}
            onChange={handleInputChange}
            onImageChange={(e) => setFormData((p) => ({ ...p, images: e.target.files[0] }))}
            onSubmit={handleSubmit}
            onCancel={() => setViewMode("list")}
          />
        )}
      </main>
      <Footer />
    </div>
  );
}

const ActivityCard = ({ activity, onEdit, onDelete }) => (
  <div className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-all duration-300 border border-blue-100">
    {activity.images && (
      <img src={activity.images} alt={activity.name} className="w-full h-48 object-cover" />
    )}
    <div className="p-5">
      <h3 className="text-xl font-semibold text-blue-800 mb-2">{activity.name}</h3>
      <div className="flex items-center justify-between mb-3">
        <span className="text-blue-600 font-bold">
          {activity.discount_percentage > 0 ? (
            <>
              {Math.round(activity.price * (1 - activity.discount_percentage / 100))} DZD
              <span className="line-through text-gray-400 ml-2">{activity.price} DZD</span>
            </>
          ) : (
            <>{activity.price} DZD</>
          )}
        </span>
        <span
          className={`px-2 py-1 rounded-full text-xs font-medium ${
            {
              easy: "bg-blue-100 text-blue-700",
              moderate: "bg-blue-200 text-blue-800",
              difficult: "bg-blue-300 text-blue-900",
            }[activity.difficulty_level]
          }`}
        >
          {activity.difficulty_level}
        </span>
      </div>
      <p className="text-gray-600 text-sm mb-4 line-clamp-3">{activity.description}</p>
      <div className="flex gap-3">
        <button
          onClick={() => onEdit(activity)}
          className="flex-1 bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition-all duration-300 shadow-sm"
        >
          Modifier
        </button>
        <button
          onClick={() => onDelete(activity.tour_announcement_id)}
          className="flex-1 bg-red-500 text-white py-2 px-4 rounded-lg hover:bg-red-600 transition-all duration-300 shadow-sm"
        >
          Supprimer
        </button>
      </div>
    </div>
  </div>
);

const ActivityForm = ({ formData, isEditing, onChange, onImageChange, onSubmit, onCancel }) => (
  <form onSubmit={onSubmit} className="bg-white p-6 rounded-xl shadow-md border border-blue-100">
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
      <InputField label="Nom *" name="name" value={formData.name} onChange={onChange} required />
      <InputField
        label="Prix (DZD) *"
        type="number"
        name="price"
        value={formData.price}
        onChange={onChange}
        step="0.01"
        required
      />
      <InputField
        label="Date de début *"
        type="date"
        name="start_date"
        value={formData.start_date}
        onChange={onChange}
        required
      />
      <InputField
        label="Date de fin *"
        type="date"
        name="end_date"
        value={formData.end_date}
        onChange={onChange}
        required
      />
      <InputField label="Durée" name="duration" value={formData.duration} onChange={onChange} />
      <InputField
        label="Participants max"
        type="number"
        name="max_participants"
        value={formData.max_participants}
        onChange={onChange}
        min="1"
      />
      <InputField
        label="Remise (%)"
        type="number"
        name="discount_percentage"
        value={formData.discount_percentage ?? ""}
        onChange={onChange}
        step="0.01"
        min="0"
        max="100"
      />
      <InputField label="Localisation" name="location" value={formData.location} onChange={onChange} />
      <SelectField
        label="Difficulté"
        name="difficulty_level"
        value={formData.difficulty_level}
        onChange={onChange}
        options={[
          { value: "easy", label: "Facile" },
          { value: "moderate", label: "Modérée" },
          { value: "difficult", label: "Difficile" },
        ]}
      />
      <SelectField
        label="Langue"
        name="language"
        value={formData.language}
        onChange={onChange}
        options={[
          { value: "Français", label: "Français" },
          { value: "Anglais", label: "Anglais" },
          { value: "Arabe", label: "Arabe" },
        ]}
      />
      <div className="col-span-full">
        <label className="block text-sm font-medium text-blue-700 mb-2">Image</label>
        <input
          type="file"
          accept="image/*"
          onChange={onImageChange}
          className="w-full px-4 py-2 border-2 border-blue-200 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400 bg-blue-50 text-gray-700 transition-colors duration-200"
        />
        {formData.images && typeof formData.images === "string" && (
          <img src={formData.images} alt="Aperçu" className="mt-3 w-40 h-40 object-cover rounded-lg shadow-sm" />
        )}
      </div>
      <div className="col-span-full">
        <label className="block text-sm font-medium text-blue-700 mb-2">Description</label>
        <textarea
          name="description"
          value={formData.description}
          onChange={onChange}
          className="w-full px-4 py-2 border-2 border-blue-200 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400 bg-blue-50 text-gray-700 transition-colors duration-200 h-32"
        />
      </div>
      <div className="col-span-full">
        <label className="block text-sm font-medium text-blue-700 mb-2">Matériel à apporter</label>
        <textarea
          name="what_to_bring"
          value={formData.what_to_bring}
          onChange={onChange}
          className="w-full px-4 py-2 border-2 border-blue-200 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400 bg-blue-50 text-gray-700 transition-colors duration-200 h-32"
        />
      </div>
      <InputField
        label="Point de rencontre"
        name="meeting_point"
        value={formData.meeting_point}
        onChange={onChange}
      />
      <CheckboxField label="Guide inclus" name="is_guided" checked={formData.is_guided} onChange={onChange} />
      <CheckboxField
        label="Disponible"
        name="is_available"
        checked={formData.is_available}
        onChange={onChange}
      />
      <div className="col-span-full flex gap-4 mt-6">
        <button
          type="submit"
          className="flex-1 bg-blue-600 text-white py-3 px-6 rounded-full hover:bg-blue-700 transition-all duration-300 shadow-md"
        >
          {isEditing ? "Mettre à jour" : "Créer activité"}
        </button>
        <button
          type="button"
          onClick={onCancel}
          className="flex-1 bg-gray-200 text-gray-700 py-3 px-6 rounded-full hover:bg-gray-300 transition-all duration-300 shadow-md"
        >
          Annuler
        </button>
      </div>
    </div>
  </form>
);

const InputField = ({ label, type = "text", name, value, onChange, required, ...props }) => (
  <div>
    <label className="block text-sm font-medium text-blue-700 mb-2">{label}</label>
    <input
      type={type}
      name={name}
      value={value}
      onChange={onChange}
      className="w-full px-4 py-2 border-2 border-blue-200 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400 bg-blue-50 text-gray-700 transition-colors duration-200"
      required={required}
      {...props}
    />
  </div>
);

const SelectField = ({ label, name, value, onChange, options }) => (
  <div>
    <label className="block text-sm font-medium text-blue-700 mb-2">{label}</label>
    <select
      name={name}
      value={value}
      onChange={onChange}
      className="w-full px-4 py-2 border-2 border-blue-200 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400 bg-blue-50 text-gray-700 transition-colors duration-200"
    >
      {options.map((opt) => (
        <option key={opt.value} value={opt.value}>
          {opt.label}
        </option>
      ))}
    </select>
  </div>
);

const CheckboxField = ({ label, name, checked, onChange }) => (
  <div className="flex items-center space-x-2">
    <input
      type="checkbox"
      name={name}
      checked={checked}
      onChange={onChange}
      className="h-5 w-5 text-blue-600 border-blue-200 rounded focus:ring-blue-400 bg-blue-50 transition-colors duration-200"
    />
    <label className="text-sm font-medium text-blue-700">{label}</label>
  </div>
);