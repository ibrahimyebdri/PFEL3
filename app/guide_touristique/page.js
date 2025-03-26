"use client";

import { useState, useEffect } from "react";
import { createClient } from "@supabase/supabase-js";
import HeaderAdminA from "@/components/HeaderAdminA";
import { useRouter } from "next/navigation";
import Footer from "@/components/Footer";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

export default function GuideTouristiqueAdmin() {
  const [reservations, setReservations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const router = useRouter();

  useEffect(() => {
    const fetchUser = async () => {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) {
        router.push("/auth");
        return;
      }

      const { data: userData, error: roleError } = await supabase
        .from("users")
        .select("role")
        .eq("user_id", user.id)
        .single();

      if (roleError || !userData || userData.role !== "tour_organizer") {
        setError("Accès refusé : Vous n'avez pas les autorisations nécessaires.");
        setLoading(false);
        setTimeout(() => router.push("/"), 2000);
        return;
      }

      fetchReservations(user.id);
    };
    fetchUser();
  }, [router]);

  const fetchReservations = async (userId) => {
    try {
      // Récupérer les activités du guide touristique
      const { data: activityData, error: activityError } = await supabase
        .from("tour_announcements")
        .select("tour_announcement_id, name")
        .eq("user_id", userId);
      if (activityError) throw activityError;

      const activityIds = activityData.map((a) => a.tour_announcement_id);
      const activityMap = new Map(activityData.map((a) => [a.tour_announcement_id, a.name]));

      // Récupérer les réservations avec les informations des utilisateurs
      const { data, error } = await supabase
        .from("reservations")
        .select(`
          *,
          users (
            user_id,
            first_name,
            last_name,
            phone_number,
            email
          )
        `)
        .eq("reservation_type", "tour_activity")
        .in("reservation_type_id", activityIds);

      if (error) throw error;

      const enrichedReservations = (data || []).map((reservation) => ({
        ...reservation,
        activity_name: activityMap.get(reservation.reservation_type_id) || "N/A",
        user_first_name: reservation.users?.first_name || "N/A",
        user_last_name: reservation.users?.last_name || "N/A",
        user_phone: reservation.users?.phone_number || "N/A",
        user_email: reservation.users?.email || "N/A",
      }));

      setReservations(enrichedReservations);
    } catch (err) {
      setError("Erreur lors de la récupération des réservations : " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleConfirm = async (reservationId) => {
    const { error } = await supabase
      .from("reservations")
      .update({ status: "confirmed" })
      .eq("reservation_id", reservationId);
    if (error) {
      console.error("Erreur lors de la confirmation :", error.message);
    } else {
      setReservations(
        reservations.map((r) =>
          r.reservation_id === reservationId ? { ...r, status: "confirmed" } : r
        )
      );
    }
  };

  const handleCancel = async (reservationId) => {
    const { error } = await supabase
      .from("reservations")
      .update({ status: "canceled" })
      .eq("reservation_id", reservationId);
    if (error) {
      console.error("Erreur lors de l'annulation :", error.message);
    } else {
      setReservations(
        reservations.map((r) =>
          r.reservation_id === reservationId ? { ...r, status: "canceled" } : r
        )
      );
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  if (error) {
    return <div className="text-center py-8 text-red-500 bg-gray-100 min-h-screen">{error}</div>;
  }

  return (
    <div className="min-h-screen bg-gray-100">
      <HeaderAdminA />
      <section className="max-w-7xl mx-auto p-6">
        <h1 className="text-3xl font-bold text-blue-800 mb-6">Dashboard Admin - Guide Touristique</h1>

        {/* Statistiques */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
          <div className="p-4 bg-white rounded-xl shadow-md border border-blue-100">
            <p className="text-blue-700 font-medium">Réservations en cours</p>
            <p className="text-2xl font-bold text-blue-600">
              {reservations.filter((r) => r.status === "pending" || r.status === "confirmed").length}
            </p>
          </div>
          <div className="p-4 bg-white rounded-xl shadow-md border border-blue-100">
            <p className="text-blue-700 font-medium">Nouvelles réservations (7 jours)</p>
            <p className="text-2xl font-bold text-blue-600">
              {
                reservations.filter(
                  (r) => new Date(r.booking_date) > new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)
                ).length
              }
            </p>
          </div>
          <div className="p-4 bg-white rounded-xl shadow-md border border-blue-100">
            <p className="text-blue-700 font-medium">Réservations annulées</p>
            <p className="text-2xl font-bold text-blue-600">
              {reservations.filter((r) => r.status === "canceled").length}
            </p>
          </div>
        </div>

        {/* Tableau des réservations */}
        <h2 className="text-xl font-semibold text-blue-800 mb-4">Réservations</h2>
        <div className="overflow-x-auto bg-white rounded-xl shadow-md border border-blue-100">
          <table className="w-full text-left">
            <thead className="bg-blue-50">
              <tr>
                <th className="p-4 text-blue-700 font-medium">Date</th>
                <th className="p-4 text-blue-700 font-medium">Activité</th>
                <th className="p-4 text-blue-700 font-medium">Nom</th>
                <th className="p-4 text-blue-700 font-medium">Prénom</th>
                <th className="p-4 text-blue-700 font-medium">Téléphone</th>
                <th className="p-4 text-blue-700 font-medium">Email</th>
                <th className="p-4 text-blue-700 font-medium">Personnes</th>
                <th className="p-4 text-blue-700 font-medium">Statut</th>
                <th className="p-4 text-blue-700 font-medium">Actions</th>
              </tr>
            </thead>
            <tbody>
              {reservations.map((reservation) => (
                <tr key={reservation.reservation_id} className="border-t border-blue-100 hover:bg-blue-50 transition-colors">
                  <td className="p-4 text-gray-700">
                    {new Date(reservation.booking_date).toLocaleDateString()}
                  </td>
                  <td className="p-4 text-gray-700">{reservation.activity_name}</td>
                  <td className="p-4 text-gray-700">{reservation.user_last_name}</td>
                  <td className="p-4 text-gray-700">{reservation.user_first_name}</td>
                  <td className="p-4 text-gray-700">{reservation.user_phone}</td>
                  <td className="p-4 text-gray-700">{reservation.user_email}</td>
                  <td className="p-4 text-gray-700">{reservation.number_of_people}</td>
                  <td className="p-4">
                    <span
                      className={`px-2 py-1 rounded-full text-sm font-medium ${
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
                  <td className="p-4">
                    {reservation.status === "pending" && (
                      <div className="flex gap-2">
                        <button
                          className="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-600 transition-all duration-200 shadow-sm"
                          onClick={() => handleConfirm(reservation.reservation_id)}
                        >
                          Confirmer
                        </button>
                        <button
                          className="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 transition-all duration-200 shadow-sm"
                          onClick={() => handleCancel(reservation.reservation_id)}
                        >
                          Annuler
                        </button>
                      </div>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
      <Footer />
    </div>
  );
}