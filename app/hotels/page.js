"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import HotelOfferCard from "@/components/HotelOfferCard";

// Fonction pour obtenir la date actuelle au format YYYY-MM-DD
const getCurrentDate = () => {
  const today = new Date();
  return today.toISOString().split("T")[0]; // Format YYYY-MM-DD
};

// Liste des wilayas d'Algérie
const wilayas = [
  "Adrar", "Chlef", "Laghouat", "Oum El Bouaghi", "Batna", "Béjaïa", "Biskra",
  "Béchar", "Blida", "Bouira", "Tamanrasset", "Tébessa", "Tlemcen", "Tiaret",
  "Tizi Ouzou", "Alger", "Djelfa", "Jijel", "Sétif", "Saïda", "Skikda",
  "Sidi Bel Abbès", "Annaba", "Guelma", "Constantine", "Médéa", "Mostaganem",
  "M'Sila", "Mascara", "Ouargla", "Oran", "El Bayadh", "Illizi",
  "Bordj Bou Arreridj", "Boumerdès", "El Tarf", "Tindouf", "Tissemsilt",
  "El Oued", "Khenchela", "Souk Ahras", "Tipaza", "Mila", "Aïn Defla",
  "Naâma", "Aïn Témouchent", "Ghardaïa", "Relizane"
];

export default function HotelsPage() {
  const router = useRouter();
  const [hotels, setHotels] = useState([]);
  const [filteredHotels, setFilteredHotels] = useState([]);
  const [displayedHotels, setDisplayedHotels] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [destination, setDestination] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isError, setIsError] = useState(false);
  const [arrivalDate, setArrivalDate] = useState(getCurrentDate());
  const [isDateError, setIsDateError] = useState(false);
  const [displayLimit, setDisplayLimit] = useState(9); // Limite initiale à 9
  const [isSearched, setIsSearched] = useState(false);

  const fullPhrase = "TROUVER VOTRE HÔTEL";

  // Récupération des données depuis Supabase
  useEffect(() => {
    const fetchHotels = async () => {
      try {
        const { data, error } = await supabase
          .from("hotels")
          .select(`
            hotel_id, name, location, images, star_rating,
            hotel_offers(price)
          `)
          .order("price", { foreignTable: "hotel_offers", ascending: true })
          .limit(1, { foreignTable: "hotel_offers" });

        if (error) throw error;

        if (!data || data.length === 0) {
          setError("Aucun hôtel disponible pour le moment.");
          setHotels([]);
          setFilteredHotels([]);
          setDisplayedHotels([]);
          return;
        }

        const hotelsWithData = data.map((hotel) => ({
          hotel_id: hotel.hotel_id,
          id: hotel.hotel_id, // Pour cohérence avec HotelOfferCard
          name: hotel.name || "Hôtel sans nom",
          location: hotel.location || "Lieu non spécifié",
          images: hotel.images && hotel.images.startsWith("http")
            ? hotel.images
            : `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/hotels-images/${hotel.images}`,
          star_rating: hotel.star_rating || 0,
          price: hotel.hotel_offers && hotel.hotel_offers.length > 0
            ? `${hotel.hotel_offers[0].price}`
            : "Sur demande",
        // Placeholder si absent
        }));

        setHotels(hotelsWithData);
        setFilteredHotels(hotelsWithData);
        if (!isSearched) {
          setDisplayedHotels(hotelsWithData.slice(0, displayLimit));
        }
      } catch (err) {
        setError("Erreur lors de la récupération des hôtels : " + err.message);
        console.error("Erreur dans fetchHotels:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchHotels();
  }, [displayLimit, isSearched]);

  // Gestion de la saisie de la destination
  const handleInputChange = (e) => {
    const value = e.target.value;
    setDestination(value);
    setIsError(false);
    if (value.length > 0) {
      const filteredSuggestions = wilayas.filter((wilaya) =>
        wilaya.toLowerCase().includes(value.toLowerCase())
      );
      setSuggestions(filteredSuggestions);
      setShowSuggestions(true);
    } else {
      setSuggestions([]);
      setShowSuggestions(false);
    }
  };

  // Sélectionner une suggestion
  const handleSuggestionClick = (wilaya) => {
    setDestination(wilaya);
    setSuggestions([]);
    setShowSuggestions(false);
    setIsError(false);
  };

  // Gestion du changement de date
  const handleDateChange = (e) => {
    const selectedDate = e.target.value;
    setArrivalDate(selectedDate);
    setIsDateError(new Date(selectedDate) < new Date(getCurrentDate()));
  };

  // Soumission du formulaire
  const handleSubmit = (e) => {
    e.preventDefault();
    if (!wilayas.includes(destination)) {
      setIsError(true);
      return;
    }
    if (isDateError) return;

    setIsSearched(true);
    const filtered = hotels.filter((hotel) =>
      hotel.location.toLowerCase().includes(destination.toLowerCase())
    );
    setFilteredHotels(filtered);
    setDisplayedHotels(filtered.slice(0, displayLimit));

    // Optionnel : redirection comme dans la page fournie
    // router.push(`/rechercheH?destination=${encodeURIComponent(destination)}&arrivalDate=${encodeURIComponent(arrivalDate)}`);
  };

  // Gestion du bouton "Afficher plus"
  const handleShowMore = () => {
    setDisplayLimit((prev) => prev + 9);
    setDisplayedHotels(filteredHotels.slice(0, displayLimit + 9));
  };

  // Interpolation des couleurs pour le texte animé
  const getColor = (percentage) => {
    const colors = [
      { r: 0, g: 217, b: 255 },  // Cyan
      { r: 148, g: 0, b: 211 },  // Violet
      { r: 255, g: 0, b: 106 },  // Rose vif
      { r: 255, g: 69, b: 0 },   // Orange
    ];
    const index = Math.floor(percentage * (colors.length - 1));
    const { r, g, b } = colors[index];
    return `rgb(${r}, ${g}, ${b})`;
  };

  if (loading)
    return (
      <div className="text-center py-8 text-green-500 bg-gray-900 min-h-screen flex items-center justify-center">
        Chargement des hôtels...
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

      <main className="bg-gradient-to-b from-gray-900 to-green-900">
        {/* Section Hero avec image statique */}
        <div className="relative">
          <img
            src="https://www.fabrispartners.it/public/explorer/Progetti/immagini%20galleria/sheraton_orano/03.jpg"
            alt="Hôtel"
            className="w-full h-[300px] sm:h-[400px] md:h-[500px] object-cover opacity-80"
          />
          <div className="absolute inset-0 flex items-center justify-center bg-black/40 px-4">
            <div className="flex justify-center whitespace-nowrap">
              {fullPhrase.split("").map((char, i) => (
                <span
                  key={i}
                  className="font-bold text-white text-2xl sm:text-3xl md:text-4xl lg:text-5xl"
                  style={{
                    animation: `fadeInOut 2s ${i * 0.1}s infinite`,
                    textShadow: `0 0 10px ${getColor(i / (fullPhrase.length - 1))},
                                 0 0 20px ${getColor(i / (fullPhrase.length - 1))},
                                 0 0 30px ${getColor(i / (fullPhrase.length - 1))}`,
                  }}
                >
                  {char === " " ? "\u00A0" : char}
                </span>
              ))}
            </div>
          </div>

          {/* Formulaire de recherche */}
          <div className="absolute left-1/2 transform -translate-x-1/2 top-[70%] sm:top-auto sm:bottom-[-40px] z-20 w-[90%] max-w-3xl px-2 sm:px-4">
            <div className="bg-white/20 backdrop-blur-lg rounded-xl p-4 sm:p-6 shadow-2xl border border-green-500/30">
              <form
                onSubmit={handleSubmit}
                className="flex flex-col sm:flex-row items-center gap-4"
              >
                <div className="w-full relative">
                
                  <input
                    id="destination"
                    type="text"
                    placeholder="Entrez une destination"
                    value={destination}
                    onChange={handleInputChange}
                    className={`w-full p-3 mt-1 rounded-lg border ${
                      isError ? "border-red-500" : "border-green-500/50"
                    } bg-white/10 placeholder-green-300 text-white focus:outline-none focus:ring-2 ${
                      isError ? "focus:ring-red-500" : "focus:ring-green-500"
                    } transition-all`}
                    required
                  />
                  {showSuggestions && suggestions.length > 0 && (
                    <ul className="absolute z-30 w-full bg-gray-800 border border-gray-600 rounded-lg mt-1 max-h-48 overflow-y-auto">
                      {suggestions.map((wilaya, index) => (
                        <li
                          key={index}
                          onClick={() => handleSuggestionClick(wilaya)}
                          className="p-2 hover:bg-gray-700 cursor-pointer text-white"
                        >
                          {wilaya}
                        </li>
                      ))}
                    </ul>
                  )}
                  {isError && (
                    <p className="text-red-500 text-sm mt-1">
                      Veuillez choisir une wilaya valide.
                    </p>
                  )}
                </div>
                <div className="w-full">
                
                  <input
                    id="arrivee-date"
                    type="date"
                    value={arrivalDate}
                    onChange={handleDateChange}
                    min={getCurrentDate()}
                    className="w-full p-3 mt-1 rounded-lg border border-green-500/50 bg-white/10 text-white focus:outline-none focus:ring-2 focus:ring-green-500 transition-all"
                    required
                  />
                  {isDateError && (
                    <p className="text-red-500 text-sm mt-1">
                      Veuillez choisir une date valide (pas dans le passé).
                    </p>
                  )}
                </div>
                <button
                  type="submit"
                  className="w-full sm:w-auto bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition-all hover:scale-105"
                >
                  Rechercher
                </button>
              </form>
            </div>
          </div>
        </div>

        {/* Section des hôtels */}
        <section className="px-6 py-16 mt-20">
          <div className="max-w-screen-xl mx-auto text-center">
            <p className="text-lg text-green-300 mb-8">
              {isSearched && filteredHotels.length === 0
                ? "Aucun hôtel trouvé pour cette recherche."
                : "Découvrez nos offres de réservation d'hôtels en Algérie."}
            </p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {displayedHotels.map((hotel) => (
                <HotelOfferCard key={hotel.hotel_id} hotel={hotel} />
              ))}
            </div>
            {displayedHotels.length < filteredHotels.length && (
              <div className="mt-8 text-center">
                <button
                  onClick={handleShowMore}
                  className="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition-all hover:scale-105"
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