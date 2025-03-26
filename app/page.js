"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import Carousel from "@/components/Carousel";
import HotelOfferCard from "@/components/HotelOfferCard";
import RestaurantCard from "@/components/Restaurantscard";
import ActivityOfferCard from "@/components/ActivityOfferCard";
import Link from "next/link";

// Fonction pour obtenir la date actuelle au format YYYY-MM-DD
const getCurrentDate = () => {
  const today = new Date();
  return today.toISOString().split("T")[0];
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

export default function Page() {
  const router = useRouter();
  const [hotels, setHotels] = useState([]);
  const [restaurants, setRestaurants] = useState([]);
  const [activities, setActivities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [destination, setDestination] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isError, setIsError] = useState(false);
  const [arrivalDate, setArrivalDate] = useState(getCurrentDate());
  const [isDateError, setIsDateError] = useState(false);

  // Récupérer les données depuis Supabase
  useEffect(() => {
    const fetchHotels = async () => {
      const { data, error } = await supabase
        .from("hotels")
        .select(`
          hotel_id, name, location, images, star_rating,
          hotel_offers(price)
        `)
        .order("price", { foreignTable: "hotel_offers", ascending: true })
        .limit(3, { foreignTable: "hotel_offers" });

      if (error) {
        setError(error.message);
      } else {
        const hotelsWithData = data.map((hotel) => ({
          ...hotel,
          images: hotel.images && hotel.images.startsWith("http")
            ? hotel.images
            : `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/hotels-images/${hotel.images}`,
          price:
            hotel.hotel_offers && hotel.hotel_offers.length > 0
              ? ` ${hotel.hotel_offers[0].price}`
              : "Sur demande",
        }));
        setHotels(hotelsWithData);
      }
    };

    const fetchRestaurants = async () => {
      const { data, error } = await supabase
        .from("restaurants")
        .select("*")
        .eq("status", "approved")
        .order("created_at", { ascending: false })
        .limit(3);

      if (error) {
        setError(error.message);
      } else {
        const formattedRestaurants = data.map((restaurant) => ({
          restaurant_id: restaurant.restaurant_id,
          id: restaurant.restaurant_id,
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
      }
    };

    const fetchActivitiesAndAdventures = async () => {
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
        .eq("is_available", true)
        .limit(3);

      if (error) {
        setError(error.message);
      } else {
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
      }
    };

    Promise.all([fetchHotels(), fetchRestaurants(), fetchActivitiesAndAdventures()])
      .then(() => setLoading(false))
      .catch(() => setLoading(false));
  }, []);

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

  // Soumission du formulaire avec redirection
  const handleSubmit = (e) => {
    e.preventDefault();
    if (!wilayas.includes(destination)) {
      setIsError(true);
      return;
    }
    if (isDateError) return;
    router.push(
      `/rechercheH?destination=${encodeURIComponent(
        destination
      )}&arrivalDate=${encodeURIComponent(arrivalDate)}`
    );
  };

  if (loading)
    return <div className="text-center py-8">Chargement...</div>;
  if (error)
    return <div className="text-center py-8 text-red-500">Erreur: {error}</div>;

  return (
    <div className="bg-gray-50">
      <Header />
      <main>
        {/* Hero Section avec Carousel */}
        <div className="relative">
          <Carousel />
          <div className="absolute left-1/2 transform -translate-x-1/2 top-[70%] sm:top-auto sm:bottom-[-40px] z-20 w-[90%] max-w-3xl">
            <div className="bg-white/30 backdrop-blur-md rounded-xl p-6 shadow-2xl">
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
                      isError ? "border-red-500" : "border-white/50"
                    } bg-white/20 placeholder-gray-700 text-gray-700 focus:outline-none focus:ring-2 ${
                      isError ? "focus:ring-red-500" : "focus:ring-white/70"
                    }`}
                    required
                  />
                  {showSuggestions && suggestions.length > 0 && (
                    <ul className="absolute z-10 w-full bg-white border border-gray-300 rounded-lg mt-1 max-h-48 overflow-y-auto">
                      {suggestions.map((wilaya, index) => (
                        <li
                          key={index}
                          onClick={() => handleSuggestionClick(wilaya)}
                          className="p-2 hover:bg-gray-100 cursor-pointer"
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
                    className="w-full p-3 mt-1 rounded-lg border border-white/50 bg-white/20 text-gray-700 focus:outline-none focus:ring-2 focus:ring-white/70"
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
                  className="w-full sm:w-auto bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition-colors"
                >
                  Rechercher
                </button>
              </form>
            </div>
          </div>
        </div>

        {/* Section Hôtels */}
        <section className="px-4 sm:px-6 py-16 mt-20">
          <div className="max-w-screen-xl mx-auto text-center">
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-4">Nos Hôtels</h2>
            <p className="text-base sm:text-lg text-gray-600 mb-8">
              Découvrez nos meilleures offres d’hôtels en Algérie.
            </p>
            <div className="flex flex-wrap justify-center gap-6">
              {hotels.map((hotel) => (
                <div key={hotel.hotel_id} className="w-full sm:w-[calc(50%-1.5rem)] lg:w-[calc(33.33%-1.5rem)]">
                  <HotelOfferCard hotel={hotel} />
                </div>
              ))}
            </div>
            <Link
              href="/hotels"
              className="mt-8 inline-block bg-blue-600 text-white py-2 px-6 rounded-lg hover:bg-blue-700 transition-colors"
            >
              Voir tous les hôtels
            </Link>
          </div>
        </section>

        {/* Section Restaurants */}
        <section className="px-4 sm:px-6 py-16 bg-gray-100">
          <div className="max-w-screen-xl mx-auto text-center">
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-4">Nos Restaurants</h2>
            <p className="text-base sm:text-lg text-gray-600 mb-8">
              Savourez les meilleurs plats dans les restaurants d’Algérie.
            </p>
            <div className="flex flex-wrap justify-center gap-6">
              {restaurants.map((restaurant) => (
                <div key={restaurant.restaurant_id} className="w-full sm:w-[calc(50%-1.5rem)] lg:w-[calc(33.33%-1.5rem)]">
                  <RestaurantCard restaurant={restaurant} />
                </div>
              ))}
            </div>
            <Link
              href="/restaurant"
              className="mt-8 inline-block bg-orange-600 text-white py-2 px-6 rounded-lg hover:bg-orange-700 transition-colors"
            >
              Explorer tous les restaurants
            </Link>
          </div>
        </section>

        {/* Section Activités et Aventures */}
        <section className="px-4 sm:px-6 py-16">
          <div className="max-w-screen-xl mx-auto text-center">
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-4">Activités et Aventures</h2>
            <p className="text-base sm:text-lg text-gray-600 mb-8">
              Vivez des expériences uniques avec nos activités et aventures.
            </p>
            <div className="flex flex-wrap justify-center gap-6">
              {activities.map((activity) => (
                <div key={activity.tour_announcement_id} className="w-full sm:w-[calc(50%-1.5rem)] lg:w-[calc(33.33%-1.5rem)]">
                  <ActivityOfferCard activity={activity} />
                </div>
              ))}
            </div>
            <Link
              href="/activities"
              className="mt-8 inline-block bg-blue-600 text-white py-2 px-6 rounded-lg hover:bg-blue-700 transition-colors"
            >
              Découvrir toutes les activités
            </Link>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}