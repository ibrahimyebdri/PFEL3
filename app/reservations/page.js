"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

const PopupMessage = ({ message, onClose }) => (
  <div className="fixed inset-0 bg-black/60 flex items-center justify-center z-50">
    <div className="bg-white p-6 rounded-2xl shadow-2xl max-w-sm w-full">
      <p className="text-xl font-semibold text-gray-800 mb-4">{message}</p>
      <button
        onClick={onClose}
        className="bg-blue-900 text-white px-5 py-2 rounded-full  transition duration-300 shadow-md w-full"
      >
        OK
      </button>
    </div>
  </div>
);

const Reservations = () => {
  const router = useRouter();
  const [reservations, setReservations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [popupMessage, setPopupMessage] = useState("");
  const [showPopup, setShowPopup] = useState(false);

  const loadReservations = async () => {
    const { data: { user }, error: userError } = await supabase.auth.getUser();
    if (userError || !user) {
      router.push("/auth");
      return;
    }
    const { data, error } = await supabase
      .from("reservations")
      .select("*")
      .eq("user_id", user.id);
    if (error) {
      console.error("Erreur lors du chargement des réservations :", error);
      setPopupMessage("Erreur lors du chargement des réservations");
      setShowPopup(true);
    } else {
      setReservations(data);
    }
    setLoading(false);
  };

  useEffect(() => {
    loadReservations();
  }, []);

  const cancelReservation = async (reservation_id) => {
    const { data, error } = await supabase
      .from("reservations")
      .update({ status: "canceled" })
      .eq("reservation_id", reservation_id)
      .select()
      .single();
    if (error) {
      console.error("Erreur lors de l'annulation :", error);
      setPopupMessage("Erreur lors de l'annulation de la réservation");
      setShowPopup(true);
      return;
    }
    loadReservations();
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-900"></div>
      </div>
    );
  }

  return (
    <div className="bg-gray-100 min-h-screen">
      <Header />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <h2 className="text-3xl sm:text-4xl font-bold text-blue-800 mb-8 text-center">
          Mes Réservations
        </h2>

        {/* Conteneur flexible pour le tableau */}
        <div className="bg-white rounded-2xl shadow-lg overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead className="bg-blue-900 text-white">
                <tr>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Type</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Personnes</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Durée</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Date</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Paiement</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Statut</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Demande spéciale</th>
                  <th className="px-4 py-3 sm:px-6 sm:py-4 text-sm sm:text-base font-semibold">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {reservations.length === 0 ? (
                  <tr>
                    <td colSpan="8" className="px-4 py-6 sm:px-6 text-center text-gray-500">
                      Aucune réservation trouvée.
                    </td>
                  </tr>
                ) : (
                  reservations.map((reservation) => (
                    <tr
                      key={reservation.reservation_id}
                      className="hover:bg-blue-50 transition duration-200"
                    >
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        {reservation.reservation_type === "hotel_offer"
                          ? "Offre Hôtel"
                          : reservation.reservation_type === "hotel_service"
                          ? "Service Hôtel"
                          : reservation.reservation_type === "tour_activity"
                          ? "Activité Touristique"
                          : reservation.reservation_type}
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        {reservation.number_of_people}
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        {reservation.duration ? `${reservation.duration} jour(s)` : "N/A"}
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        {reservation.booking_date
                          ? new Date(reservation.booking_date).toLocaleDateString()
                          : "N/A"}
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        <span
                          className={`px-2 py-1 rounded-full text-xs ${
                            reservation.payment_status === "paid"
                              ? "bg-green-100 text-green-800"
                              : "bg-yellow-100 text-yellow-800"
                          }`}
                        >
                          {reservation.payment_status}
                        </span>
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        <span
                          className={`px-2 py-1 rounded-full text-xs ${
                            reservation.status === "pending"
                              ? "bg-yellow-100 text-yellow-800"
                              : reservation.status === "confirmed"
                              ? "bg-green-100 text-green-800"
                              : "bg-red-100 text-red-800"
                          }`}
                        >
                          {reservation.status}
                        </span>
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700 text-sm sm:text-base">
                        {reservation.special_request || "-"}
                      </td>
                      <td className="px-4 py-3 sm:px-6 sm:py-4 text-gray-700">
                        {reservation.status === "pending" ? (
                          <button
                            onClick={() => cancelReservation(reservation.reservation_id)}
                            className="bg-red-500 text-white px-3 py-1 sm:px-4 sm:py-2 rounded-full hover:bg-red-600 transition duration-300 shadow-sm text-sm sm:text-base"
                          >
                            Annuler
                          </button>
                        ) : (
                          <span className="text-gray-500">-</span>
                        )}
                      </td>
                    </tr>
                  ))
                )}
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

export default Reservations;