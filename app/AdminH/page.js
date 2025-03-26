"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import HeaderAdminH from "@/components/HeaderAdminH";
import Footer from "@/components/Footer";

// Composant pour afficher un message popup
const PopupMessage = ({ message, onClose }) => (
  <div className="fixed inset-0 bg-black/60 flex items-center justify-center z-50">
    <div className="bg-white p-8 rounded-2xl shadow-2xl max-w-md">
      <p className="text-2xl font-bold mb-6 text-gray-800">{message}</p>
      <button
        onClick={onClose}
        className="bg-indigo-600 text-white px-6 py-3 rounded-full shadow-lg hover:bg-indigo-700 transition duration-300"
      >
        OK
      </button>
    </div>
  </div>
);

const AdminH = () => {
  const router = useRouter();
  const [reservations, setReservations] = useState([]);
  const [offers, setOffers] = useState([]);
  const [services, setServices] = useState([]);
  const [hotels, setHotels] = useState([]);
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState(null);
  const [popupMessage, setPopupMessage] = useState("");
  const [showPopup, setShowPopup] = useState(false);

  // Fonction pour charger les réservations avec la jointure sur users et le tri par date décroissante
  const loadReservations = async () => {
    if (offers.length === 0 && services.length === 0) return;
    const { data: reservationsData, error: reservationsError } = await supabase
      .from("reservations")
      .select("*, user:users(first_name,last_name,phone_number)")
      .in("reservation_type", ["hotel_offer", "hotel_service"]);
    if (reservationsError) {
      console.error("Erreur chargement réservations :", reservationsError);
      return;
    }
    const offerIds = offers.map(o => o.hotel_offer_id);
    const serviceIds = services.map(s => s.hotel_service_id);
    const filteredReservations = reservationsData.filter(r => {
      if (r.reservation_type === "hotel_offer") {
        return offerIds.includes(r.reservation_type_id);
      } else if (r.reservation_type === "hotel_service") {
        return serviceIds.includes(r.reservation_type_id);
      }
      return false;
    });
    filteredReservations.sort((a, b) => {
      const dateA = a.booking_date ? new Date(a.booking_date).getTime() : 0;
      const dateB = b.booking_date ? new Date(b.booking_date).getTime() : 0;
      return dateB - dateA;
    });
    setReservations(filteredReservations);
  };

  // Récupération de l'utilisateur et de l'hôtel associé
  useEffect(() => {
    const fetchUserAndHotel = async () => {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) {
        router.push("/auth");
        return;
      }
  
      // Vérification du rôle de l'utilisateur
      const { data: userData, error: roleError } = await supabase
        .from("users")
        .select("role")
        .eq("user_id", user.id)
        .single();
  
      if (roleError || !userData || userData.role !== "hotel_admin") {
        setPopupMessage("Accès refusé : Vous n'avez pas les autorisations nécessaires.");
        setShowPopup(true);
        setLoading(false);
        setTimeout(() => {
          router.push("/"); // Redirige vers la page d'accueil après 2 secondes
        }, 2000);
        return;
      }
  
      setUser(user);
  
      const { data: hotelData } = await supabase
        .from("hotels")
        .select("*")
        .eq("admin_id", user.id)
        .maybeSingle();
  
      if (!hotelData) {
        setHotels([]);
        setPopupMessage("Aucun hôtel associé n'a été trouvé. Veuillez créer un hôtel.");
        setShowPopup(true);
      } else {
        setHotels([hotelData]);
      }
      setLoading(false);
    };
    fetchUserAndHotel();
  }, [router]);
  // Chargement des offres de l'hôtel
  useEffect(() => {
    const fetchOffers = async () => {
      if (hotels.length === 0) return;
      const currentHotel = hotels[0];
      const { data: offersData, error: offersError } = await supabase
        .from("hotel_offers")
        .select("*")
        .eq("hotel_id", currentHotel.hotel_id);
      if (offersError) {
        console.error("Erreur chargement offres :", offersError);
      } else {
        setOffers(offersData);
      }
    };
    fetchOffers();
  }, [hotels]);

  // Chargement des services de l'hôtel
  useEffect(() => {
    const fetchServices = async () => {
      if (hotels.length === 0) return;
      const currentHotel = hotels[0];
      const { data: servicesData, error: servicesError } = await supabase
        .from("hotel_services")
        .select("*")
        .eq("hotel_id", currentHotel.hotel_id);
      if (servicesError) {
        console.error("Erreur chargement services :", servicesError);
      } else {
        setServices(servicesData);
      }
    };
    fetchServices();
  }, [hotels]);

  // Lorsque les offres ou services sont chargés, on recharge les réservations
  useEffect(() => {
    loadReservations();
  }, [offers, services]);

  // Mise à jour du statut de la réservation via le dropdown
  const updateReservationStatus = async (reservation_id, newStatus) => {
    const { data, error } = await supabase
      .from("reservations")
      .update({ status: newStatus })
      .eq("reservation_id", reservation_id)
      .select() // Retourner la ligne mise à jour
      .single();
    if (error) {
      console.error("Erreur lors de la mise à jour du statut", error);
      setPopupMessage("Erreur lors de la mise à jour du statut");
      setShowPopup(true);
      return;
    }
    // Rechargez l'ensemble des réservations pour inclure le join avec user
    loadReservations();
  };

  // Mise à jour du paiement via le dropdown
  const updatePaymentStatus = async (reservation_id, newPaymentStatus) => {
    const { data, error } = await supabase
      .from("reservations")
      .update({ payment_status: newPaymentStatus })
      .eq("reservation_id", reservation_id)
      .select()
      .single();
    if (error) {
      console.error("Erreur lors de la mise à jour du paiement", error);
      setPopupMessage("Erreur lors de la mise à jour du paiement");
      setShowPopup(true);
      return;
    }
    loadReservations();
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center text-3xl font-bold text-indigo-600">
        Chargement...
      </div>
    );
  }

  return (
    <div>
      <HeaderAdminH />
      <div className="container mx-auto p-8 bg-gradient-to-r from-indigo-100 to-purple-100 min-h-screen">
        <h2 className="text-4xl font-extrabold text-gray-800 mb-8 text-center">
          Tableau de Bord
        </h2>
        <div className="bg-white p-8 rounded-3xl shadow-2xl mb-10">
          <h3 className="text-2xl font-bold text-indigo-700 mb-6">
            Gestion des Réservations (Offres & Services)
          </h3>
          <div className="overflow-x-auto">
            <table className="w-full min-w-max bg-white rounded-xl shadow-lg">
              <thead className="bg-gradient-to-r from-gray-800 to-gray-900 text-white">
                <tr>
                  <th className="px-6 py-4 text-left font-semibold">Utilisateur</th>
                  <th className="px-6 py-4 text-left font-semibold">Téléphone</th>
                  <th className="px-6 py-4 text-left font-semibold">Type de Réservation</th>
                  <th className="px-6 py-4 text-left font-semibold">Réservation</th>
                  <th className="px-6 py-4 text-left font-semibold">Durée</th>
                  <th className="px-6 py-4 text-left font-semibold">Date</th>
                  <th className="px-6 py-4 text-left font-semibold">Paiement</th>
                  <th className="px-6 py-4 text-left font-semibold">Statut</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-300">
                {reservations
                  .filter((reservation) => reservation != null)
                  .map((reservation) => {
                    const reservedItem =
                      reservation.reservation_type === "hotel_offer"
                        ? offers.find(
                            (o) => o.hotel_offer_id === reservation.reservation_type_id
                          )
                        : services.find(
                            (s) => s.hotel_service_id === reservation.reservation_type_id
                          );
                    const reservedItemName = reservedItem ? reservedItem.name : "N/A";
                    const userName = reservation.user
                      ? `${reservation.user.first_name} ${reservation.user.last_name}`
                      : "N/A";
                    const userPhone = reservation.user ? reservation.user.phone_number : "N/A";

                    return (
                      <tr key={reservation.reservation_id} className="hover:bg-indigo-50 transition duration-300">
                        <td className="px-6 py-4 text-gray-800">{userName}</td>
                        <td className="px-6 py-4 text-gray-800">{userPhone}</td>
                        <td className="px-6 py-4 text-gray-800">
                          {reservation.reservation_type === "hotel_offer" ? "Offre Hôtel" : "Service Hôtel"}
                        </td>
                        <td className="px-6 py-4 text-gray-800">{reservedItemName}</td>
                        <td className="px-6 py-4 text-gray-800">{reservation.duration} jour(s)</td>
                        <td className="px-6 py-4 text-gray-800">
                          {reservation.booking_date
                            ? new Date(reservation.booking_date).toLocaleString()
                            : "N/A"}
                        </td>
                        <td className="px-6 py-4 text-gray-800">
                          <select
                            value={reservation.payment_status}
                            onChange={(e) =>
                              updatePaymentStatus(reservation.reservation_id, e.target.value)
                            }
                            className="p-2 border border-gray-300 rounded-full shadow-sm hover:shadow-lg transition duration-300 bg-white text-gray-700"
                          >
                            <option value="pending">En attente</option>
                            <option value="paid">Payé</option>
                            <option value="failed">Échoué</option>
                            <option value="refunded">Remboursé</option>
                          </select>
                        </td>
                        <td className="px-6 py-4 text-gray-800">
                          <select
                            value={reservation.status}
                            onChange={(e) =>
                              updateReservationStatus(reservation.reservation_id, e.target.value)
                            }
                            className="p-2 border border-gray-300 rounded-full shadow-sm hover:shadow-lg transition duration-300 bg-white text-gray-700"
                          >
                            <option value="pending">En attente</option>
                            <option value="confirmed">Confirmé</option>
                            <option value="canceled">Annulé</option>
                          </select>
                        </td>
                      </tr>
                    );
                  })}
              </tbody>
            </table>
          </div>
        </div>
        {showPopup && (
          <PopupMessage message={popupMessage} onClose={() => setShowPopup(false)} />
        )}
      </div>
      <Footer />
    </div>
  );
};

export default AdminH;
