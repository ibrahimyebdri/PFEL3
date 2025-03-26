"use client";

import { useState, useEffect } from "react";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import RestaurantCard from "@/components/Restaurantscard";

const RestaurantsPage = () => {
  const [restaurants, setRestaurants] = useState([]);
  const [filteredRestaurants, setFilteredRestaurants] = useState([]);
  const [displayedRestaurants, setDisplayedRestaurants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [displayLimit, setDisplayLimit] = useState(9); // Limite initiale à 9
  const [isSearched, setIsSearched] = useState(false);

  const line1 = "DÉCOUVREZ LES MEILLEURS";
  const line2 = "RESTAURANTS";

  useEffect(() => {
    const fetchRestaurants = async () => {
      try {
        const { data, error } = await supabase
          .from("restaurants")
          .select("*")
          .eq("status", "approved")
          .order("created_at", { ascending: false });

        if (error) throw error;

        if (!data || data.length === 0) {
          setError("Aucun restaurant disponible pour le moment.");
          setRestaurants([]);
          setFilteredRestaurants([]);
          setDisplayedRestaurants([]);
          return;
        }

        const formattedRestaurants = data.map((restaurant) => ({
          restaurant_id: restaurant.restaurant_id,
          id: restaurant.restaurant_id, // Pour cohérence
          name: restaurant.name || "Restaurant sans nom",
          location: restaurant.location || "Lieu non spécifié",
          description: restaurant.description || "Aucune description disponible",
          cuisine_type: restaurant.cuisine_type || "Non spécifié",
          star_rating: restaurant.star_rating || 0,
          images: restaurant.images || "",
          opening_hours: restaurant.opening_hours || "Horaires non disponibles",
          phone_number: restaurant.phone_number || "Non disponible",
          menu: restaurant.menu || "",
        }));

        setRestaurants(formattedRestaurants);
        setFilteredRestaurants(formattedRestaurants);
        if (!isSearched) {
          setDisplayedRestaurants(formattedRestaurants.slice(0, displayLimit));
        }
      } catch (err) {
        setError("Erreur lors de la récupération des restaurants : " + err.message);
        console.error("Erreur dans fetchRestaurants:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchRestaurants();
  }, [displayLimit, isSearched]);

  // Gestion de la recherche
  const handleSearchSubmit = (e) => {
    e.preventDefault();
    setIsSearched(true);

    let filtered = [...restaurants];
    if (searchTerm) {
      filtered = filtered.filter(
        (restaurant) =>
          restaurant.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
          restaurant.location.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    setFilteredRestaurants(filtered);
    setDisplayedRestaurants(filtered.slice(0, displayLimit));
  };

  // Gestion du bouton "Afficher plus"
  const handleShowMore = () => {
    setDisplayLimit((prev) => prev + 9);
    setDisplayedRestaurants(filteredRestaurants.slice(0, displayLimit + 9));
  };

  // Interpolation fluide des couleurs orange
  const getColor = (index, totalLength) => {
    const colors = [
      { r: 255, g: 147, b: 0 },  // Orange vif (début)
      {  r: 255, g: 110, b: 64}, // Orange moyen
      { r: 255, g: 195, b: 70 },  // Doré
      { r: 255, g: 110, b: 64 }, // Corail (fin)
    ];
    const scaledIndex = (index / (totalLength - 1)) * (colors.length - 1);
    const lowerIndex = Math.floor(scaledIndex);
    const upperIndex = Math.min(lowerIndex + 1, colors.length - 1);
    const fraction = scaledIndex - lowerIndex;

    if (lowerIndex === upperIndex) {
      const { r, g, b } = colors[lowerIndex];
      return `rgb(${r}, ${g}, ${b})`;
    }

    const r = Math.round(
      colors[lowerIndex].r + (colors[upperIndex].r - colors[lowerIndex].r) * fraction
    );
    const g = Math.round(
      colors[lowerIndex].g + (colors[upperIndex].g - colors[lowerIndex].g) * fraction
    );
    const b = Math.round(
      colors[lowerIndex].b + (colors[upperIndex].b - colors[lowerIndex].b) * fraction
    );

    return `rgb(${r}, ${g}, ${b})`;
  };

  // Fonction pour gérer les coupures avec tiret
  const renderTextWithHyphenation = (text) => {
    return text.split("").map((char, i) => (
      <span
        key={i}
        className="font-extrabold text-xl sm:text-2xl md:text-3xl lg:text-4xl xl:text-5xl tracking-wide"
        style={{
          color: getColor(i, text.length),
        }}
      >
        {char === " " ? "\u00A0" : char}
      </span>
    ));
  };

  if (loading)
    return (
      <div className="text-center py-8 text-orange-500 bg-gray-900 min-h-screen flex items-center justify-center">
        Chargement des restaurants...
      </div>
    );
  if (error)
    return (
      <div className="text-center py-8 text-red-500 bg-gray-900 min-h-screen">
        Erreur : {error}
      </div>
    );

  return (
    <div className="bg-gray-900 text-white">
      <Header />

      <main className="bg-gradient-to-b from-gray-900 to-orange-900">
        {/* Section Hero avec vidéo */}
        <div className="relative">
          <video
            src="/video/video.mp4" // Chemin relatif depuis /public
            autoPlay
            loop
            muted
            playsInline
            className="w-full h-[300px] sm:h-[400px] md:h-[500px] object-cover opacity-80"
          />
          <div className="absolute inset-0 flex items-center justify-center bg-black/40 px-4">
            <div className="text-center">
              <div className="flex flex-col items-center">
                <div className="flex flex-wrap justify-center hyphens-auto">
                  {renderTextWithHyphenation(line1)}
                </div>
                <div className="mt-2 flex flex-wrap justify-center hyphens-auto">
                  {renderTextWithHyphenation(line2)}
                </div>
              </div>
            </div>
          </div>

          {/* Formulaire de recherche */}
          <div className="absolute left-1/2 transform -translate-x-1/2 top-[60%] sm:top-auto sm:bottom-[-40px] z-20 w-[90%] sm:w-[80%] md:w-[70%] max-w-3xl px-2 sm:px-4">
            <div className="bg-white/20 backdrop-blur-lg rounded-xl p-4 sm:p-6 shadow-2xl border border-orange-500/30">
              <form
                onSubmit={handleSearchSubmit}
                className="flex flex-col sm:flex-row items-center gap-3 sm:gap-4"
              >
                <div className="w-full">
                  <input
                    id="search"
                    type="text"
                    placeholder="Rechercher un restaurant ou une ville..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="w-full p-2 sm:p-3 rounded-lg border border-orange-500/50 bg-white/10 placeholder-orange-300 text-white focus:outline-none focus:ring-2 focus:ring-orange-500 transition-all text-sm sm:text-base"
                  />
                </div>
                <button
                  type="submit"
                  className="w-full sm:w-auto bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 px-4 sm:py-3 sm:px-6 rounded-lg transition-all hover:scale-105 text-sm sm:text-base"
                >
                  Rechercher
                </button>
              </form>
            </div>
          </div>
        </div>

        {/* Résultats de recherche */}
        <section className="px-4 sm:px-6 py-12 sm:py-16 mt-16 sm:mt-20">
          <div className="max-w-screen-xl mx-auto">
            <p className="text-base sm:text-lg text-orange-300 mb-6 sm:mb-8 text-center">
              {isSearched && filteredRestaurants.length === 0
                ? "Aucun restaurant trouvé pour cette recherche."
                : "Découvrez les meilleurs restaurants en Algérie."}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 justify-items-center">
              {displayedRestaurants.map((restaurant) => (
                <RestaurantCard key={restaurant.restaurant_id} restaurant={restaurant} />
              ))}
            </div>
            {displayedRestaurants.length < filteredRestaurants.length && (
              <div className="mt-6 sm:mt-8 text-center">
                <button
                  onClick={handleShowMore}
                  className="bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 sm:py-3 px-4 sm:px-6 rounded-lg transition-all hover:scale-105 text-sm sm:text-base"
                >
                  Afficher plus
                </button>
              </div>
            )}
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
};

export default RestaurantsPage;