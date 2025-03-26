"use client";

import { useState, useEffect } from "react";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import ActivityOfferCard from "@/components/ActivityOfferCard";

export default function ActivitiesPage() {
  const [activities, setActivities] = useState([]);
  const [filteredActivities, setFilteredActivities] = useState([]);
  const [displayedActivities, setDisplayedActivities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [displayLimit, setDisplayLimit] = useState(9);
  const [isSearched, setIsSearched] = useState(false);

  const line1 = "LES MEILLEURES";
  const line2 = "ACTIVITÉS TOURISTIQUES";

  useEffect(() => {
    const fetchActivities = async () => {
      try {
        const { data, error } = await supabase
          .from("tour_announcements")
          .select(`
            tour_announcement_id,
            name,
            description,
            price,
            new_price,
            discount_percentage,
            start_date,
            end_date,
            location,
            images,
            duration,
            difficulty_level,
            max_participants
          `)
          .eq("is_available", true);

        if (error) throw error;
        if (!data || data.length === 0) {
          setError("Aucune activité disponible pour le moment.");
          setActivities([]);
          setFilteredActivities([]);
          setDisplayedActivities([]);
          return;
        }

        const formattedActivities = data.map((activity) => ({
          tour_announcement_id: activity.tour_announcement_id,
          id: activity.tour_announcement_id,
          name: activity.name || "Activité sans nom",
          price: activity.price || 0,
          new_price: activity.new_price || null,
          discount_percentage: activity.discount_percentage || 0,
          start_date: activity.start_date || "Date non spécifiée",
          end_date: activity.end_date || "Date non spécifiée",
          location: activity.location || "Lieu non spécifié",
          images: activity.images || "",
          duration: activity.duration || "Non spécifiée",
          difficulty_level: activity.difficulty_level || "N/A",
          description: activity.description || "Aucune description disponible",
          max_participants: activity.max_participants || "Non limité",
        }));

        setActivities(formattedActivities);
        setFilteredActivities(formattedActivities);
        setDisplayedActivities(formattedActivities.slice(0, displayLimit));
      } catch (err) {
        setError("Erreur lors de la récupération des activités : " + err.message);
        console.error("Erreur dans fetchActivities:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchActivities();
  }, []); // Pas de dépendances dynamiques ici

  useEffect(() => {
    setDisplayedActivities(filteredActivities.slice(0, displayLimit));
  }, [filteredActivities, displayLimit]);

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    setIsSearched(true);

    const filtered = activities.filter(
      (activity) =>
        activity.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        activity.location.toLowerCase().includes(searchTerm.toLowerCase())
    );

    setFilteredActivities(filtered);
  };

  const handleShowMore = () => {
    setDisplayLimit((prev) => prev + 9);
  };

  const getColor = (index, totalLength) => {
    const colors = [
      { r: 0, g: 102, b: 204 },
      { r: 0, g: 153, b: 255 },
      { r: 51, g: 204, b: 255 },
    ];
    const scaledIndex = (index / (totalLength - 1)) * (colors.length - 1);
    const lowerIndex = Math.floor(scaledIndex);
    const upperIndex = Math.min(lowerIndex + 1, colors.length - 1);
    const fraction = scaledIndex - lowerIndex;

    if (lowerIndex === upperIndex) {
      const { r, g, b } = colors[lowerIndex];
      return `rgb(${r}, ${g}, ${b})`;
    }

    const r = Math.round(colors[lowerIndex].r + (colors[upperIndex].r - colors[lowerIndex].r) * fraction);
    const g = Math.round(colors[lowerIndex].g + (colors[upperIndex].g - colors[lowerIndex].g) * fraction);
    const b = Math.round(colors[lowerIndex].b + (colors[upperIndex].b - colors[lowerIndex].b) * fraction);

    return `rgb(${r}, ${g}, ${b})`;
  };

  const renderTextWithHyphenation = (text) => {
    return text.split("").map((char, i) => (
      <span
        key={i}
        className="font-extrabold text-xl sm:text-2xl md:text-3xl lg:text-4xl xl:text-5xl tracking-wide"
        style={{ color: getColor(i, text.length) }}
      >
        {char === " " ? "\u00A0" : char}
      </span>
    ));
  };

  if (loading) {
    return (
      <div className="text-center py-8 text-blue-500 bg-gray-900 min-h-screen flex items-center justify-center">
        Chargement des activités...
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center py-8 text-red-500 bg-gray-900 min-h-screen">
        Erreur : {error}
      </div>
    );
  }

  return (
    <div className="bg-gray-900 text-white">
      <Header />

      <main className="bg-gradient-to-b from-gray-900 to-blue-900">
        <div className="relative">
          <video
            src="/video/videot.mp4"
            autoPlay
            loop
            muted
            playsInline
            className="w-full h-[300px] sm:h-[400px] md:h-[500px] object-cover opacity-80"
          />
          <div className="absolute inset-0 flex items-center justify-center bg-black/40 px-4">
            <div className="text-center">
              <div className="flex flex-col items-center">
                <div className="flex flex-wrap justify-center hyphens-auto">{renderTextWithHyphenation(line1)}</div>
                <div className="mt-2 flex flex-wrap justify-center hyphens-auto">{renderTextWithHyphenation(line2)}</div>
              </div>
            </div>
          </div>

          <div className="absolute left-1/2 transform -translate-x-1/2 top-[60%] sm:top-auto sm:bottom-[-40px] z-20 w-[90%] sm:w-[80%] md:w-[70%] max-w-3xl px-2 sm:px-4">
            <div className="bg-white/20 backdrop-blur-lg rounded-xl p-4 sm:p-6 shadow-2xl border border-blue-500/30">
              <form onSubmit={handleSearchSubmit} className="flex flex-col sm:flex-row items-center gap-3 sm:gap-4">
                <div className="w-full">
                  <input
                    id="search"
                    type="text"
                    placeholder="Rechercher une activité ou une destination..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="w-full p-2 sm:p-3 rounded-lg border border-blue-500/50 bg-white/10 placeholder-blue-300 text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all text-sm sm:text-base"
                  />
                </div>
                <button
                  type="submit"
                  className="w-full sm:w-auto bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 sm:py-3 sm:px-6 rounded-lg transition-all hover:scale-105 text-sm sm:text-base"
                >
                  Rechercher
                </button>
              </form>
            </div>
          </div>
        </div>

        <section className="px-4 sm:px-6 py-12 sm:py-16 mt-16 sm:mt-20">
          <div className="max-w-screen-xl mx-auto">
            <p className="text-base sm:text-lg text-blue-300 mb-6 sm:mb-8 text-center">
              {isSearched && filteredActivities.length === 0
                ? "Aucune activité trouvée pour cette recherche."
                : "Découvrez les meilleures activités touristiques en Algérie."}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 justify-items-center">
              {displayedActivities.map((activity) => (
                <ActivityOfferCard key={activity.tour_announcement_id} activity={activity} />
              ))}
            </div>
            {displayedActivities.length < filteredActivities.length && (
              <div className="mt-6 sm:mt-8 text-center">
                <button
                  onClick={handleShowMore}
                  className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 sm:py-3 px-4 sm:px-6 rounded-lg transition-all hover:scale-105 text-sm sm:text-base"
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
}