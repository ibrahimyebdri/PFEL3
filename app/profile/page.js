"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

const ProfilePage = () => {
  const router = useRouter();
  const [user, setUser] = useState(null);
  const [editMode, setEditMode] = useState(false);
  const [formData, setFormData] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const { data: { user: authUser }, error: authError } = await supabase.auth.getUser();
        if (authError || !authUser) {
          throw new Error("Utilisateur non connecté. Veuillez vous connecter.");
        }

        const { data: userData, error: userError } = await supabase
          .from("users")
          .select("*")
          .eq("user_id", authUser.id)
          .single();

        if (userError) {
          throw new Error(`Erreur lors de la récupération des données : ${userError.message}`);
        }

        setUser(userData);
        setFormData({
          first_name: userData.first_name || "",
          last_name: userData.last_name || "",
          username: userData.username || "",
          phone_number: userData.phone_number || "",
          nationality: userData.nationality || "",
          address: userData.address || "",
          profession: userData.profession || "",
        });
      } catch (err) {
        setError(err.message);
        if (err.message.includes("Utilisateur non connecté")) {
          router.push("/auth");
        }
      } finally {
        setLoading(false);
      }
    };

    fetchUserData();
  }, [router]);

  const handleInputChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleUpdateProfile = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    setSuccess("");

    try {
      const { error: updateError } = await supabase
        .from("users")
        .update({
          first_name: formData.first_name,
          last_name: formData.last_name,
          username: formData.username,
          phone_number: formData.phone_number,
          nationality: formData.nationality,
          address: formData.address,
          profession: formData.profession,
          updated_at: new Date().toISOString(),
        })
        .eq("user_id", user.user_id);

      if (updateError) {
        throw new Error(`Erreur lors de la mise à jour : ${updateError.message}`);
      }

      setUser({ ...user, ...formData });
      setSuccess("Profil mis à jour avec succès !");
      setEditMode(false);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteAccount = async () => {
    setLoading(true);
    setError("");
    setSuccess("");

    try {
      const { error: rpcError } = await supabase.rpc("delete_user");
      if (rpcError) {
        throw new Error(`Erreur lors de la suppression du compte : ${rpcError.message}`);
      }

      await supabase.auth.signOut();
      setSuccess("Compte supprimé avec succès !");
      router.push("/");
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
      setShowDeleteDialog(false);
    }
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    router.push("/");
  };

  if (loading && !user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
        <p className="text-gray-600 text-lg animate-pulse">Chargement...</p>
      </div>
    );
  }

  if (error && !user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
        <p className="text-red-600 text-lg">{error}</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 text-gray-900 font-sans">
      <Header />

      <main className="py-20 px-4 sm:px-6 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-5xl font-bold text-center mb-16 text-gray-800 tracking-tight">
            Mon Profil
          </h1>

          <div className="bg-white shadow-xl rounded-xl p-10 transition-all duration-300 hover:shadow-2xl border border-gray-100">
            {success && (
              <div className="mb-6 p-4 bg-teal-50 text-teal-700 rounded-lg border border-teal-200 animate-fade-in">
                {success}
              </div>
            )}
            {error && (
              <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg border border-red-200 animate-fade-in">
                {error}
              </div>
            )}

            {!editMode ? (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div className="space-y-4">
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Prénom :</label>
                    <p className="text-gray-800">{user.first_name}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Nom :</label>
                    <p className="text-gray-800">{user.last_name}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Nom d'utilisateur :</label>
                    <p className="text-gray-800">{user.username}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Email :</label>
                    <p className="text-gray-800">{user.email}</p>
                  </div>
                </div>
                <div className="space-y-4">
                  {user.nationality && (
                    <div className="flex items-center gap-4">
                      <label className="text-lg font-medium text-gray-500 w-40">Nationalité :</label>
                      <p className="text-gray-800">{user.nationality}</p>
                    </div>
                  )}
                  {user.address && (
                    <div className="flex items-center gap-4">
                      <label className="text-lg font-medium text-gray-500 w-40">Adresse :</label>
                      <p className="text-gray-800">{user.address}</p>
                    </div>
                  )}
                  {user.profession && (
                    <div className="flex items-center gap-4">
                      <label className="text-lg font-medium text-gray-500 w-40">Profession :</label>
                      <p className="text-gray-800">{user.profession}</p>
                    </div>
                  )}
                  {user.phone_number && (
                    <div className="flex items-center gap-4">
                      <label className="text-lg font-medium text-gray-500 w-40">Téléphone :</label>
                      <p className="text-gray-800">{user.phone_number}</p>
                    </div>
                  )}
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Rôle :</label>
                    <p className="text-gray-800">{user.role}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Compte vérifié :</label>
                    <p className="text-gray-800">{user.verified_account ? "Oui" : "Non"}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Inscrit le :</label>
                    <p className="text-gray-800">{new Date(user.created_at).toLocaleDateString()}</p>
                  </div>
                </div>

                <div className="mt-10 col-span-1 md:col-span-2 flex flex-col sm:flex-row gap-4 justify-center">
                  <button
                    onClick={() => setEditMode(true)}
                    className="bg-gray-800 hover:bg-gray-900 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 hover:scale-105 hover:shadow-lg"
                  >
                    Modifier le profil
                  </button>
                  <button
                    onClick={handleLogout}
                    className="bg-gray-500 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 hover:scale-105 hover:shadow-lg"
                  >
                    Se déconnecter
                  </button>
                  {user.role === "visitor" && (
                    <button
                      onClick={() => setShowDeleteDialog(true)}
                      className="bg-red-500 hover:bg-red-600 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 hover:scale-105 hover:shadow-lg"
                    >
                      Supprimer le compte
                    </button>
                  )}
                </div>
              </div>
            ) : (
              <form onSubmit={handleUpdateProfile} className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div className="space-y-6">
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Prénom :</label>
                    <input
                      type="text"
                      name="first_name"
                      value={formData.first_name}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                      required
                    />
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Nom :</label>
                    <input
                      type="text"
                      name="last_name"
                      value={formData.last_name}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                      required
                    />
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Nom d'utilisateur :</label>
                    <input
                      type="text"
                      name="username"
                      value={formData.username}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                      required
                    />
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Téléphone :</label>
                    <input
                      type="text"
                      name="phone_number"
                      value={formData.phone_number}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                    />
                  </div>
                </div>
                <div className="space-y-6">
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Nationalité :</label>
                    <input
                      type="text"
                      name="nationality"
                      value={formData.nationality}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                    />
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Adresse :</label>
                    <input
                      type="text"
                      name="address"
                      value={formData.address}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                    />
                  </div>
                  <div className="flex items-center gap-4">
                    <label className="text-lg font-medium text-gray-500 w-40">Profession :</label>
                    <input
                      type="text"
                      name="profession"
                      value={formData.profession}
                      onChange={handleInputChange}
                      className="flex-1 p-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 transition-all duration-300 bg-white"
                    />
                  </div>
                </div>

                <div className="mt-10 col-span-1 md:col-span-2 flex flex-col sm:flex-row gap-4 justify-center">
                  <button
                    type="submit"
                    disabled={loading}
                    className="bg-gray-800 hover:bg-gray-900 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 hover:scale-105 hover:shadow-lg disabled:bg-gray-400 disabled:cursor-not-allowed"
                  >
                    {loading ? "Enregistrement..." : "Enregistrer"}
                  </button>
                  <button
                    type="button"
                    onClick={() => setEditMode(false)}
                    className="bg-gray-500 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 hover:scale-105 hover:shadow-lg"
                  >
                    Annuler
                  </button>
                </div>
              </form>
            )}
          </div>
        </div>

        {showDeleteDialog && (
          <dialog
            open
            className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-60 z-50 backdrop-blur-sm"
          >
            <div className="bg-white rounded-xl p-8 shadow-2xl max-w-md w-full">
              <h2 className="text-2xl font-bold text-gray-800 mb-4">Confirmer la suppression</h2>
              <p className="text-gray-600 mb-6">
                Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.
              </p>
              <div className="flex gap-4 justify-end">
                <button
                  onClick={() => setShowDeleteDialog(false)}
                  className="bg-gray-500 hover:bg-gray-600 text-white font-medium py-2 px-4 rounded-lg transition-all duration-300"
                >
                  Annuler
                </button>
                <button
                  onClick={handleDeleteAccount}
                  className="bg-red-500 hover:bg-red-600 text-white font-medium py-2 px-4 rounded-lg transition-all duration-300"
                >
                  Supprimer
                </button>
              </div>
            </div>
          </dialog>
        )}
      </main>

      <Footer />
    </div>
  );
};

export default ProfilePage;