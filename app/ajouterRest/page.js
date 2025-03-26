"use client";

import { useState } from 'react';
import { supabase } from '@/lib/supabase';
import { useRouter } from 'next/navigation';
import Header from '@/components/Header';
import Footer from '@/components/Footer';

const AddRestaurantPage = () => {
  const router = useRouter();
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    location: '',
    phone_number: '',
    email: '',
    speciality: '',
    star_rating: 0,
    cuisine_type: '',
    dress_code: '',
    payment_methods: [],
    additional_notes: ''
  });

  const [openingHours, setOpeningHours] = useState({
    Lundi: { open: '08:00', close: '22:00', closed: false },
    Mardi: { open: '08:00', close: '22:00', closed: false },
    Mercredi: { open: '08:00', close: '22:00', closed: false },
    Jeudi: { open: '08:00', close: '22:00', closed: false },
    Vendredi: { open: '08:00', close: '22:00', closed: false },
    Samedi: { open: '08:00', close: '22:00', closed: false },
    Dimanche: { open: '08:00', close: '22:00', closed: false }
  });

  const [mainImage, setMainImage] = useState(null);
  const [menuImage, setMenuImage] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);

  const handleInputChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleOpeningHoursChange = (day, field, value) => {
    setOpeningHours((prev) => ({
      ...prev,
      [day]: {
        ...prev[day],
        [field]: value
      }
    }));
  };

  const toggleClosed = (day) => {
    setOpeningHours((prev) => ({
      ...prev,
      [day]: {
        ...prev[day],
        closed: !prev[day].closed
      }
    }));
  };

  const sanitizeFileName = (name) => {
    return name
      .toLowerCase()
      .replace(/\s+/g, '-')
      .replace(/[^a-z0-9-]/g, '');
  };

  const formatOpeningHoursToText = () => {
    return Object.entries(openingHours)
      .map(([day, { open, close, closed }]) => {
        if (closed) return `${day} : Fermé`;
        return `${day} : ${open} - ${close}`;
      })
      .join('\n');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      if (!formData.name || !mainImage || !menuImage || !formData.location || !formData.email) {
        throw new Error('Les champs obligatoires (nom, images, localisation, email) doivent être remplis');
      }

      const sanitizedName = sanitizeFileName(formData.name);
      const folderPath = `Restaurants_photos/public/${sanitizedName}/`;

      const mainExt = mainImage.name.split('.').pop();
      const mainImagePath = `${folderPath}main.${mainExt}`;
      const { error: mainError } = await supabase.storage
        .from('Restaurants_photos')
        .upload(mainImagePath, mainImage);
      if (mainError) throw new Error(`Erreur upload image principale : ${mainError.message}`);

      const menuExt = menuImage.name.split('.').pop();
      const menuImagePath = `${folderPath}menu.${menuExt}`;
      const { error: menuError } = await supabase.storage
        .from('Restaurants_photos')
        .upload(menuImagePath, menuImage);
      if (menuError) throw new Error(`Erreur upload image menu : ${menuError.message}`);

      const { data: { publicUrl: mainImageUrl } } = supabase.storage
        .from('Restaurants_photos')
        .getPublicUrl(mainImagePath);
      const { data: { publicUrl: menuImageUrl } } = supabase.storage
        .from('Restaurants_photos')
        .getPublicUrl(menuImagePath);

      const restaurantData = {
        ...formData,
        images: mainImageUrl,
        menu: menuImageUrl,
        opening_hours: formatOpeningHoursToText(),
        payment_methods: formData.payment_methods.join(', '),
        created_at: new Date().toISOString(),
        status: 'pending'
      };

      const { error: dbError } = await supabase
        .from('restaurants')
        .insert([restaurantData]);

      if (dbError) throw new Error(`Erreur insertion base de données : ${dbError.message}`);

      setSuccess(true);
    } catch (err) {
      setError(err.message);
      console.error('Erreur complète :', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-900 text-gray-800">
      <Header />

      <main className="relative bg-gradient-to-b from-gray-900 to-orange-900 py-16 px-4 sm:px-6 lg:px-8 overflow-hidden">
        {/* Effet de fond animé sombre */}
        <div className="absolute inset-0 pointer-events-none">
          <div className="w-80 h-80 bg-orange-600/30 rounded-full blur-3xl absolute top-0 left-0 animate-pulse-slow"></div>
          <div className="w-96 h-96 bg-orange-700/30 rounded-full blur-3xl absolute bottom-0 right-0 animate-pulse-slow delay-500"></div>
          <div className="w-64 h-64 bg-orange-500/30 rounded-full blur-3xl absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 animate-float"></div>
        </div>

        <div className="max-w-4xl mx-auto relative z-10">
          <h1 className="text-4xl sm:text-5xl font-extrabold text-center mb-12 bg-clip-text text-transparent bg-gradient-to-r from-orange-400 via-orange-600 to-orange-800 animate-text-glow">
            Ajouter un nouveau restaurant
          </h1>

          <form onSubmit={handleSubmit} className="space-y-8 bg-white/95 backdrop-blur-2xl p-8 rounded-3xl shadow-2xl border border-orange-400/50 hover:shadow-orange-400/40 transition-all duration-500 animate-slide-in">
            {error && (
              <div className="p-4 bg-red-100/80 text-red-700 rounded-xl border border-red-400/50 animate-fade-in">
                {error}
              </div>
            )}

            {/* Nom */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Nom du restaurant *</label>
              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="Nom du restaurant"
                required
              />
            </div>

            {/* Localisation */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Localisation *</label>
              <input
                type="text"
                name="location"
                value={formData.location}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="Adresse complète"
                required
              />
            </div>

            {/* Email */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Email (pour suivi) *</label>
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="exemple@domaine.com"
                required
              />
            </div>

            {/* Type de cuisine */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Type de cuisine</label>
              <input
                type="text"
                name="cuisine_type"
                value={formData.cuisine_type}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="Ex : Algérienne, Italienne"
              />
            </div>

            {/* Description */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Description</label>
              <textarea
                name="description"
                value={formData.description}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                rows="4"
                placeholder="Décrivez votre restaurant"
              />
            </div>

            {/* Téléphone */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Numéro de téléphone</label>
              <input
                type="text"
                name="phone_number"
                value={formData.phone_number}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="Ex : +213 123 456 789"
              />
            </div>

            {/* Spécialité */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Spécialité</label>
              <input
                type="text"
                name="speciality"
                value={formData.speciality}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                placeholder="Ex : Couscous, Pizza"
              />
            </div>

            {/* Étoiles */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Évaluation (1-5)</label>
              <div className="flex gap-3">
                {[1, 2, 3, 4, 5].map((rating) => (
                  <button
                    key={rating}
                    type="button"
                    onClick={() => setFormData({ ...formData, star_rating: rating })}
                    className={`text-3xl transition-transform duration-300 hover:scale-125 transform hover:rotate-12 ${
                      rating <= formData.star_rating ? 'text-orange-500' : 'text-gray-400'
                    }`}
                  >
                    ★
                  </button>
                ))}
              </div>
            </div>

            {/* Horaires d'ouverture */}
            <div className="space-y-4">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Horaires d'ouverture *</label>
              {Object.entries(openingHours).map(([day, { open, close, closed }]) => (
                <div key={day} className="flex items-center gap-4 bg-white/50 p-4 rounded-xl border border-orange-400/30 transition-all duration-300 hover:shadow-orange-500/30">
                  <span className="w-24 text-orange-700 font-medium">{day}</span>
                  <label className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      checked={closed}
                      onChange={() => toggleClosed(day)}
                      className="w-5 h-5 rounded border-orange-400 text-orange-500 focus:ring-orange-500 bg-white/70 transition-all duration-200 hover:scale-110"
                    />
                    <span className="text-orange-600 text-sm">Fermé</span>
                  </label>
                  {!closed && (
                    <>
                      <input
                        type="time"
                        value={open}
                        onChange={(e) => handleOpeningHoursChange(day, 'open', e.target.value)}
                        className="p-2 rounded-lg border border-orange-400/60 bg-white/70 text-gray-800 focus:outline-none focus:ring-2 focus:ring-orange-500 transition-all duration-300 hover:scale-105"
                      />
                      <span className="text-orange-600">-</span>
                      <input
                        type="time"
                        value={close}
                        onChange={(e) => handleOpeningHoursChange(day, 'close', e.target.value)}
                        className="p-2 rounded-lg border border-orange-400/60 bg-white/70 text-gray-800 focus:outline-none focus:ring-2 focus:ring-orange-500 transition-all duration-300 hover:scale-105"
                      />
                    </>
                  )}
                </div>
              ))}
            </div>

            {/* Code vestimentaire */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Code vestimentaire</label>
              <select
                name="dress_code"
                value={formData.dress_code}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
              >
                <option value="" className="bg-white">Non spécifié</option>
                <option value="Casual" className="bg-white">Décontracté</option>
                <option value="Smart Casual" className="bg-white">Smart Casual</option>
                <option value="Formal" className="bg-white">Formel</option>
              </select>
            </div>

            {/* Moyens de paiement */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Moyens de paiement</label>
              <div className="grid grid-cols-2 gap-4">
                {['Espèces', 'Carte bancaire', 'Mobile'].map((method) => (
                  <label key={method} className="flex items-center space-x-3 transition-all duration-300 hover:scale-105">
                    <input
                      type="checkbox"
                      name="payment_methods"
                      value={method}
                      checked={formData.payment_methods.includes(method)}
                      onChange={(e) => {
                        const newMethods = e.target.checked
                          ? [...formData.payment_methods, e.target.value]
                          : formData.payment_methods.filter(m => m !== e.target.value);
                        setFormData({ ...formData, payment_methods: newMethods });
                      }}
                      className="w-5 h-5 rounded border-orange-400 text-orange-500 focus:ring-orange-500 bg-white/70 transition-all duration-200 hover:scale-110"
                    />
                    <span className="text-orange-700">{method}</span>
                  </label>
                ))}
              </div>
            </div>

            {/* Notes supplémentaires */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Notes supplémentaires</label>
              <textarea
                name="additional_notes"
                value={formData.additional_notes}
                onChange={handleInputChange}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 placeholder-orange-400/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all duration-300 hover:scale-105"
                rows="3"
                placeholder="Informations supplémentaires"
              />
            </div>

            {/* Image principale */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Image principale *</label>
              <input
                type="file"
                accept="image/*"
                onChange={(e) => setMainImage(e.target.files[0])}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 file:mr-4 file:py-3 file:px-6 file:rounded-xl file:border-0 file:bg-orange-500 file:text-white hover:file:bg-orange-600 transition-all duration-300 hover:scale-105"
                required
              />
              <p className="text-xs text-orange-600/80">Formats : JPG, PNG, WEBP</p>
            </div>

            {/* Image du menu */}
            <div className="space-y-2">
              <label className="block text-sm font-semibold text-orange-600 tracking-wider">Image du menu *</label>
              <input
                type="file"
                accept="image/*"
                onChange={(e) => setMenuImage(e.target.files[0])}
                className="w-full p-4 rounded-xl border border-orange-400/60 bg-white/70 text-gray-800 file:mr-4 file:py-3 file:px-6 file:rounded-xl file:border-0 file:bg-orange-500 file:text-white hover:file:bg-orange-600 transition-all duration-300 hover:scale-105"
                required
              />
              <p className="text-xs text-orange-600/80">Photo ou scan du menu</p>
            </div>

            {/* Bouton */}
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-orange-500 hover:bg-orange-600 text-white font-bold py-4 px-6 rounded-xl transition-all duration-500 hover:scale-110 hover:shadow-orange-500/50 hover:rotate-1 disabled:bg-gray-400 disabled:cursor-not-allowed shadow-md animate-pulse-slow"
            >
              {loading ? 'Envoi en cours...' : 'Soumettre la demande'}
            </button>
          </form>

          {/* Popup de confirmation */}
          {success && (
            <div className="fixed inset-0 bg-black/60 flex items-center justify-center z-50 animate-fade-in">
              <div className="bg-white rounded-2xl p-8 shadow-2xl max-w-md w-full text-center border border-orange-400/50 animate-slide-up">
                <h2 className="text-2xl font-bold text-orange-600 mb-4">Demande soumise avec succès !</h2>
                <p className="text-gray-700 mb-6">
                  Merci pour votre soumission ! Nous allons vérifier votre demande et vous contacterons bientôt via l'email fourni.
                </p>
                <button
                  onClick={() => {
                    setSuccess(false);
                    router.push('/restaurant');
                  }}
                  className="bg-orange-500 hover:bg-orange-600 text-white font-semibold py-2 px-6 rounded-lg transition-all duration-300 hover:scale-110 hover:shadow-orange-500/50"
                >
                  Fermer
                </button>
              </div>
            </div>
          )}
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default AddRestaurantPage;