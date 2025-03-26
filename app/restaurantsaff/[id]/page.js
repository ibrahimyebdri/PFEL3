"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

const RestaurantDetailPage = () => {
  const { id } = useParams();
  const [restaurant, setRestaurant] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showMenu, setShowMenu] = useState(false);
  const [showFullHours, setShowFullHours] = useState(false); // Nouvel état pour les horaires

  useEffect(() => {
    const fetchRestaurant = async () => {
      try {
        const { data, error } = await supabase
          .from("restaurants")
          .select("*")
          .eq("restaurant_id", id)
          .single();

        if (error) throw error;
        if (!data) throw new Error("Restaurant non trouvé");
        setRestaurant(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchRestaurant();
  }, [id]);

  if (loading)
    return (
      <div className="flex justify-center items-center h-screen bg-orange-50">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-orange-500"></div>
      </div>
    );

  if (error)
    return (
      <div className="text-center py-8 text-red-500 bg-orange-50 min-h-screen">
        Erreur : {error}
      </div>
    );

  // Fonction pour générer les étoiles de notation
  const renderRatingStars = () => {
    const rating = restaurant.star_rating || 0;
    return [...Array(5)].map((_, index) => (
      <span
        key={index}
        className={`text-xl ${
          index < Math.floor(rating) ? "text-yellow-400" : "text-gray-300"
        }`}
      >
        ★
      </span>
    ));
  };

  // SVG par défaut pour l'image si elle ne charge pas
  const defaultSvg = (
    <svg
      className="w-full h-full text-orange-600"
      aria-hidden="true"
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      fill="none"
      viewBox="0 0 24 24"
    >
      <path
        stroke="currentColor"
        strokeLinecap="round"
        strokeWidth="2"
        d="M8 7V6a1 1 0 0 1 1-1h11a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1h-1M3 18v-7a1 1 0 0 1 1-1h11a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1Zm8-3.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0Z"
      />
    </svg>
  );

  // Gestion des horaires : extraire le premier jour/ligne
  const openingHours = restaurant.opening_hours || "Horaires non disponibles";
  const hoursLines = openingHours.split("\n"); // Séparer par ligne
  const firstLine = hoursLines[0]; // Première ligne (premier jour)
  const hasMoreLines = hoursLines.length > 1;

  return (
    <div className="min-h-screen bg-orange-50 relative">
      <Header />

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* Image principale */}
        <div className="mb-8 relative rounded-2xl overflow-hidden shadow-2xl group">
          <div className="relative h-96 flex items-center justify-center bg-white">
            {restaurant.images && restaurant.images !== "" ? (
              <img
                src={restaurant.images}
                alt={restaurant.name}
                className="w-full h-full object-cover transition-all duration-500 group-hover:scale-105"
                onError={(e) => {
                  e.target.style.display = "none";
                  e.target.nextSibling.style.display = "flex";
                }}
              />
            ) : null}
            <div
              className="w-full h-full flex items-center justify-center"
              style={{ display: restaurant.images && restaurant.images !== "" ? "none" : "flex" }}
            >
              {defaultSvg}
            </div>
          </div>
          <div className="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent pointer-events-none"></div>
        </div>

        {/* Contenu principal */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2">
            <h1 className="text-4xl font-bold mb-4 text-orange-800">{restaurant.name}</h1>
            <div className="flex items-center gap-4 mb-6">
              <span className="bg-orange-100 text-orange-800 px-3 py-1 rounded-full">
                {restaurant.cuisine_type || "Non spécifié"}
              </span>
              <div className="flex items-center">
                {renderRatingStars()}
                <span className="ml-2 text-gray-600">
                  ({restaurant.star_rating?.toFixed(1) || "N/A"})
                </span>
              </div>
            </div>
            <p className="text-gray-600 mb-8 leading-relaxed">{restaurant.description || "Aucune description disponible"}</p>
          </div>

          {/* Coordonnées */}
          <div className="bg-white p-6 rounded-2xl shadow-2xl h-fit sticky top-8 border border-orange-200">
            <h2 className="text-2xl font-bold mb-4 text-orange-800">Coordonnées</h2>
            <div className="space-y-4 text-gray-700">
              <div>
                <h3 className="font-semibold text-orange-600">📍 Adresse</h3>
                <p>{restaurant.location || "Non spécifiée"}</p>
              </div>
              <div>
                <h3 className="font-semibold text-orange-600">📞 Téléphone</h3>
                <p>{restaurant.phone_number || "Non disponible"}</p>
              </div>
              <div>
                <h3 className="font-semibold text-orange-600">🕒 Horaires d'ouverture</h3>
                <pre className="whitespace-pre-wrap font-sans">
                  {showFullHours ? openingHours : firstLine}
                </pre>
                {hasMoreLines && !showFullHours && (
                  <button
                    onClick={() => setShowFullHours(true)}
                    className="text-orange-600 underline text-sm mt-2 hover:text-orange-800 transition-colors"
                  >
                    Voir plus
                  </button>
                )}
                {hasMoreLines && showFullHours && (
                  <button
                    onClick={() => setShowFullHours(false)}
                    className="text-orange-600 underline text-sm mt-2 hover:text-orange-800 transition-colors"
                  >
                    Voir moins
                  </button>
                )}
              </div>
            </div>

            {/* Bouton pour afficher le menu */}
            {restaurant.menu && (
              <button
                onClick={() => setShowMenu(true)}
                className="mt-6 w-full px-4 py-3 bg-gradient-to-r from-orange-600 to-orange-500 text-white font-semibold rounded-xl hover:bg-orange-700 transition-all transform hover:scale-105"
              >
                Voir le menu
              </button>
            )}
          </div>
        </div>
      </main>

      {/* Popup pour afficher la photo du menu */}
      {showMenu && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
          <div
            className="fixed inset-0"
            onClick={() => setShowMenu(false)}
          ></div>
          <div className="bg-white p-6 rounded-2xl shadow-2xl z-10 max-w-md w-full transform transition-all duration-300 scale-95">
            <h2 className="text-xl font-bold mb-4 text-orange-800">Menu</h2>
            <div className="relative flex items-center justify-center">
              {restaurant.menu && restaurant.menu !== "" ? (
                <img
                  src={restaurant.menu}
                  alt="Menu du restaurant"
                  className="w-full h-auto object-contain mb-4 rounded-xl"
                  onError={(e) => {
                    e.target.style.display = "none";
                    e.target.nextSibling.style.display = "flex";
                  }}
                />
              ) : null}
              <div
                className="w-full h-60 flex items-center justify-center"
                style={{ display: restaurant.menu && restaurant.menu !== "" ? "none" : "flex" }}
              >
                {defaultSvg}
              </div>
            </div>
            <button
              onClick={() => setShowMenu(false)}
              className="w-full px-4 py-2 bg-orange-600 text-white rounded-xl hover:bg-orange-700 transition-all transform hover:scale-105"
            >
              Fermer
            </button>
          </div>
          <style jsx>{`
            .popup-content {
              animation: popupFadeIn 0.3s ease forwards;
            }
            @keyframes popupFadeIn {
              from {
                opacity: 0;
                transform: scale(0.95);
              }
              to {
                opacity: 1;
                transform: scale(1);
              }
            }
          `}</style>
        </div>
      )}

      <Footer />
    </div>
  );
};

export default RestaurantDetailPage;