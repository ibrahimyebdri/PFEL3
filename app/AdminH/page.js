'use client';

import { useState } from "react";
import HeaderAdminH from "../components/HeaderAdminH";
import Footer from "../components/Footer";

const AdminH = () => {
  // États pour les popups
  const [isReservationPopupOpen, setIsReservationPopupOpen] = useState(false);
  const [isOfferPopupOpen, setIsOfferPopupOpen] = useState(false);
  const [isHotelPopupOpen, setIsHotelPopupOpen] = useState(false);

  // États pour l'édition
  const [editingReservation, setEditingReservation] = useState(null);
  const [editingOffer, setEditingOffer] = useState(null);
  const [editingHotel, setEditingHotel] = useState(null);

  // Données exemple basées sur votre schéma SQL
  const [reservations, setReservations] = useState([
    {
      reservation_id: 1,
      user_id: 1,
      reservation_type: "hotel_offer",
      reservation_type_id: 1,
      booking_date: "2024-02-20T14:30", // format compatible avec datetime-local
      number_of_people: 2,
      special_request: "Lit en pétales de roses",
      payment_status: "paid",
      status: "confirmed",
    },
  ]);

  const [offers, setOffers] = useState([
    {
      hotel_offer_id: 1,
      hotel_id: 1,
      name: "Pack Romance",
      description: "Suite nuptiale avec champagne et dîner",
      price: 450.0,
      room_type: "Suite Présidentielle",
      number_of_rooms: 5,
      wifi_included: true,
      breakfast_included: true,
      lunch_included: false,
      dinner_included: true,
      parking_included: false,
      pool_access: false,
      gym_access: false,
      spa_access: true,
      additional_notes: "Vue sur la mer",
      max_occupancy: 2,
      is_refundable: true,
      discount_percentage: 10,
      old_price: 500.0,
      images: "image1.jpg,image2.jpg",
      start_date: "2024-03-01",
      end_date: "2024-03-31",
    },
  ]);

  const [hotels, setHotels] = useState([
    {
      hotel_id: 1,
      name: "Hôtel El-Djazair",
      description: "Hôtel 5 étoiles face à la mer",
      location: "Alger Centre",
      phone_number: "0123456789",
      email: "contact@eldjazair.com",
      history: "Fondé en 1990...",
      star_rating: 5,
      images: "hotel1.jpg,hotel2.jpg",
      amenities: "Piscine,Spa,Restaurant gastronomique",
      check_in_time: "15:00",
      check_out_time: "12:00",
      additional_notes: "Parking gratuit",
      payment_methods: "CB,Visa,Mastercard",
    },
  ]);

  // Gestion des réservations
  const handleReservationSubmit = (reservationData) => {
    if (editingReservation) {
      setReservations(
        reservations.map((r) =>
          r.reservation_id === reservationData.reservation_id ? reservationData : r
        )
      );
    } else {
      setReservations([...reservations, { ...reservationData, reservation_id: Date.now() }]);
    }
    setIsReservationPopupOpen(false);
  };

  // Gestion des offres
  const handleOfferSubmit = (offerData) => {
    if (editingOffer) {
      setOffers(offers.map((o) => (o.hotel_offer_id === offerData.hotel_offer_id ? offerData : o)));
    } else {
      setOffers([...offers, { ...offerData, hotel_offer_id: Date.now() }]);
    }
    setIsOfferPopupOpen(false);
  };

  // Gestion des hôtels
  const handleHotelSubmit = (hotelData) => {
    if (editingHotel) {
      setHotels(hotels.map((h) => (h.hotel_id === hotelData.hotel_id ? hotelData : h)));
    } else {
      setHotels([...hotels, { ...hotelData, hotel_id: Date.now() }]);
    }
    setIsHotelPopupOpen(false);
  };

  // Suppression d'une réservation
  const deleteReservation = (id) => {
    setReservations(reservations.filter((r) => r.reservation_id !== id));
  };

  // Suppression d'une offre
  const deleteOffer = (id) => {
    setOffers(offers.filter((o) => o.hotel_offer_id !== id));
  };

  // Suppression d'un hôtel
  const deleteHotel = (id) => {
    setHotels(hotels.filter((h) => h.hotel_id !== id));
  };

  return (
    <div className="min-h-screen bg-amber-50">
      <HeaderAdminH />

      <div className="container mx-auto p-6">
        {/* Section Réservations */}
        <div className="bg-white p-6 rounded-2xl shadow-xl mb-8">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-semibold text-amber-800">Gestion des Réservations</h2>
            <button
              onClick={() => {
                setEditingReservation(null);
                setIsReservationPopupOpen(true);
              }}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              ＋ Ajouter une réservation
            </button>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full bg-amber-100 rounded-xl overflow-hidden">
              <thead className="bg-gray-800 text-white">
                <tr>
                  <th className="px-6 py-3 text-left">ID</th>
                  <th className="px-6 py-3 text-left">Type</th>
                  <th className="px-6 py-3 text-left">Date</th>
                  <th className="px-6 py-3 text-left">Statut</th>
                  <th className="px-6 py-3 text-left">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-400">
                {reservations.map((reservation) => (
                  <tr key={reservation.reservation_id} className="hover:bg-amber-200">
                    <td className="px-6 py-4">{reservation.reservation_id}</td>
                    <td className="px-6 py-4">{reservation.reservation_type}</td>
                    <td className="px-6 py-4">{reservation.booking_date}</td>
                    <td className="px-6 py-4">
                      <span
                        className={`px-3 py-1 rounded-full text-sm ${
                          reservation.status === "confirmed"
                            ? "bg-green-500"
                            : reservation.status === "pending"
                            ? "bg-yellow-500"
                            : "bg-red-500"
                        } text-white`}
                      >
                        {reservation.status}
                      </span>
                    </td>
                    <td className="px-6 py-4 space-x-2">
                      <button
                        onClick={() => {
                          setEditingReservation(reservation);
                          setIsReservationPopupOpen(true);
                        }}
                        className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                      >
                        ✎
                      </button>
                      <button
                        onClick={() => deleteReservation(reservation.reservation_id)}
                        className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                      >
                        🗑
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Section Hôtels */}
        <div className="bg-white p-6 rounded-2xl shadow-xl mb-8">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-semibold text-amber-800">Gestion des Hôtels</h2>
            <button
              onClick={() => {
                setEditingHotel(null);
                setIsHotelPopupOpen(true);
              }}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              ＋ Ajouter un hôtel
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {hotels.map((hotel) => (
              <div key={hotel.hotel_id} className="bg-amber-100 p-6 rounded-xl">
                <div className="flex justify-between items-start mb-4">
                  <h3 className="text-xl font-bold text-amber-900">{hotel.name}</h3>
                  <div className="flex gap-2">
                    <button
                      onClick={() => {
                        setEditingHotel(hotel);
                        setIsHotelPopupOpen(true);
                      }}
                      className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                    >
                      ✎
                    </button>
                    <button
                      onClick={() => deleteHotel(hotel.hotel_id)}
                      className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                    >
                      🗑
                    </button>
                  </div>
                </div>
                <p className="text-amber-800">{hotel.description}</p>
                <div className="mt-4 flex items-center">
                  <span className="text-amber-600">★ {hotel.star_rating}/5</span>
                  <span className="ml-4 text-amber-600">📍 {hotel.location}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Section Offres */}
        <div className="bg-white p-6 rounded-2xl shadow-xl mb-8">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-semibold text-amber-800">Gestion des Offres</h2>
            <button
              onClick={() => {
                setEditingOffer(null);
                setIsOfferPopupOpen(true);
              }}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              ＋ Ajouter une offre
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {offers.map((offer) => (
              <div key={offer.hotel_offer_id} className="bg-amber-100 p-6 rounded-xl">
                <div className="flex justify-between items-start mb-4">
                  <h3 className="text-xl font-bold text-amber-900">{offer.name}</h3>
                  <div className="flex gap-2">
                    <button
                      onClick={() => {
                        setEditingOffer(offer);
                        setIsOfferPopupOpen(true);
                      }}
                      className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                    >
                      ✎
                    </button>
                    <button
                      onClick={() => deleteOffer(offer.hotel_offer_id)}
                      className="bg-transparent border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-2 py-1 rounded-lg"
                    >
                      🗑
                    </button>
                  </div>
                </div>
                <p className="text-amber-800">{offer.description}</p>
                <div className="mt-4">
                  <span className="text-amber-600">💶 {offer.price}€</span>
                  <span className="ml-4 text-amber-600">🛏 {offer.room_type}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Modals */}
        {isReservationPopupOpen && (
          <ReservationFormModal
            reservation={editingReservation}
            onClose={() => setIsReservationPopupOpen(false)}
            onSubmit={handleReservationSubmit}
          />
        )}
        {isOfferPopupOpen && (
          <OfferFormModal
            offer={editingOffer}
            onClose={() => setIsOfferPopupOpen(false)}
            onSubmit={handleOfferSubmit}
          />
        )}
        {isHotelPopupOpen && (
          <HotelFormModal
            hotel={editingHotel}
            onClose={() => setIsHotelPopupOpen(false)}
            onSubmit={handleHotelSubmit}
          />
        )}
      </div>

      <Footer />
    </div>
  );
};

const ReservationFormModal = ({ reservation, onClose, onSubmit }) => {
  const [formData, setFormData] = useState(
    reservation || {
      user_id: 1,
      reservation_type: "hotel_offer",
      reservation_type_id: 1,
      booking_date: new Date().toISOString().slice(0, 16),
      number_of_people: 1,
      special_request: "",
      payment_status: "pending",
      status: "pending",
    }
  );

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-2xl p-8 w-full max-w-lg md:max-w-3xl max-h-[90vh] overflow-y-auto">
        <h3 className="text-2xl font-bold text-amber-900 mb-6">
          {reservation ? "Modifier la réservation" : "Nouvelle réservation"}
        </h3>
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Utilisateur ID
              </label>
              <input
                type="number"
                name="user_id"
                value={formData.user_id}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Type de réservation
              </label>
              <select
                name="reservation_type"
                value={formData.reservation_type}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              >
                <option value="hotel_offer">Offre hôtel</option>
                <option value="hotel_service">Service hôtel</option>
                <option value="restaurant">Restaurant</option>
                <option value="tour_activity">Activité touristique</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                ID du type de réservation
              </label>
              <input
                type="number"
                name="reservation_type_id"
                value={formData.reservation_type_id}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Date de réservation
              </label>
              <input
                type="datetime-local"
                name="booking_date"
                value={formData.booking_date}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Nombre de personnes
              </label>
              <input
                type="number"
                name="number_of_people"
                value={formData.number_of_people}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Statut du paiement
              </label>
              <select
                name="payment_status"
                value={formData.payment_status}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              >
                <option value="pending">En attente</option>
                <option value="paid">Payé</option>
                <option value="failed">Échoué</option>
                <option value="refunded">Remboursé</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Statut de la réservation
              </label>
              <select
                name="status"
                value={formData.status}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              >
                <option value="pending">En attente</option>
                <option value="confirmed">Confirmé</option>
                <option value="canceled">Annulé</option>
              </select>
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-amber-800 mb-2">
              Demande spéciale
            </label>
            <textarea
              name="special_request"
              value={formData.special_request}
              onChange={handleChange}
              className="w-full p-2 border border-amber-300 rounded-lg"
            />
          </div>
          <div className="flex justify-end gap-4">
            <button
              type="button"
              onClick={onClose}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              Annuler
            </button>
            <button
              type="submit"
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              {reservation ? "Mettre à jour" : "Créer"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

const OfferFormModal = ({ offer, onClose, onSubmit }) => {
  const [formData, setFormData] = useState(
    offer || {
      hotel_id: "",
      name: "",
      description: "",
      price: 0,
      room_type: "",
      number_of_rooms: 1,
      wifi_included: false,
      breakfast_included: false,
      lunch_included: false,
      dinner_included: false,
      parking_included: false,
      pool_access: false,
      gym_access: false,
      spa_access: false,
      additional_notes: "",
      max_occupancy: 1,
      is_refundable: false,
      discount_percentage: 0,
      old_price: 0,
      images: "",
      start_date: "",
      end_date: "",
    }
  );

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData({ ...formData, [name]: type === "checkbox" ? checked : value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-2xl p-8 w-full max-w-lg md:max-w-4xl max-h-[90vh] overflow-y-auto">
        <h3 className="text-2xl font-bold text-amber-900 mb-6">
          {offer ? "Modifier l'offre" : "Nouvelle offre"}
        </h3>
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                ID de l'hôtel
              </label>
              <input
                type="number"
                name="hotel_id"
                value={formData.hotel_id}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Nom de l'offre
              </label>
              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Description
              </label>
              <textarea
                name="description"
                value={formData.description}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Prix
              </label>
              <input
                type="number"
                step="0.01"
                name="price"
                value={formData.price}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Type de chambre
              </label>
              <input
                type="text"
                name="room_type"
                value={formData.room_type}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Nombre de chambres
              </label>
              <input
                type="number"
                name="number_of_rooms"
                value={formData.number_of_rooms}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2 grid grid-cols-2 gap-4">
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="wifi_included"
                  checked={formData.wifi_included}
                  onChange={handleChange}
                />
                Wifi inclus
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="breakfast_included"
                  checked={formData.breakfast_included}
                  onChange={handleChange}
                />
                Petit déjeuner inclus
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="lunch_included"
                  checked={formData.lunch_included}
                  onChange={handleChange}
                />
                Déjeuner inclus
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="dinner_included"
                  checked={formData.dinner_included}
                  onChange={handleChange}
                />
                Dîner inclus
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="parking_included"
                  checked={formData.parking_included}
                  onChange={handleChange}
                />
                Parking inclus
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="pool_access"
                  checked={formData.pool_access}
                  onChange={handleChange}
                />
                Accès piscine
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="gym_access"
                  checked={formData.gym_access}
                  onChange={handleChange}
                />
                Accès gym
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="spa_access"
                  checked={formData.spa_access}
                  onChange={handleChange}
                />
                Accès spa
              </label>
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Notes additionnelles
              </label>
              <textarea
                name="additional_notes"
                value={formData.additional_notes}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Capacité maximale
              </label>
              <input
                type="number"
                name="max_occupancy"
                value={formData.max_occupancy}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  name="is_refundable"
                  checked={formData.is_refundable}
                  onChange={handleChange}
                />
                Remboursable
              </label>
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Pourcentage de réduction
              </label>
              <input
                type="number"
                step="0.01"
                name="discount_percentage"
                value={formData.discount_percentage}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Ancien prix
              </label>
              <input
                type="number"
                step="0.01"
                name="old_price"
                value={formData.old_price}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Images (URLs séparées par des virgules)
              </label>
              <textarea
                name="images"
                value={formData.images}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Date de début
              </label>
              <input
                type="date"
                name="start_date"
                value={formData.start_date}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Date de fin
              </label>
              <input
                type="date"
                name="end_date"
                value={formData.end_date}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
          </div>
          <div className="flex justify-end gap-4">
            <button
              type="button"
              onClick={onClose}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              Annuler
            </button>
            <button
              type="submit"
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              {offer ? "Mettre à jour" : "Créer"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

const HotelFormModal = ({ hotel, onClose, onSubmit }) => {
  const [formData, setFormData] = useState(
    hotel || {
      name: "",
      description: "",
      location: "",
      phone_number: "",
      email: "",
      history: "",
      star_rating: 3,
      images: "",
      amenities: "",
      check_in_time: "15:00",
      check_out_time: "12:00",
      additional_notes: "",
      payment_methods: "",
    }
  );

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-2xl p-8 w-full max-w-lg md:max-w-4xl max-h-[90vh] overflow-y-auto">
        <h3 className="text-2xl font-bold text-amber-900 mb-6">
          {hotel ? "Modifier l'hôtel" : "Nouvel hôtel"}
        </h3>
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Nom</label>
              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Localisation</label>
              <input
                type="text"
                name="location"
                value={formData.location}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Téléphone</label>
              <input
                type="text"
                name="phone_number"
                value={formData.phone_number}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Email</label>
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">Description</label>
              <textarea
                name="description"
                value={formData.description}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">Historique</label>
              <textarea
                name="history"
                value={formData.history}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Étoiles</label>
              <input
                type="number"
                name="star_rating"
                min="1"
                max="5"
                value={formData.star_rating}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">
                Images (URLs séparées par des virgules)
              </label>
              <textarea
                name="images"
                value={formData.images}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">Équipements</label>
              <textarea
                name="amenities"
                value={formData.amenities}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Heure d'arrivée</label>
              <input
                type="time"
                name="check_in_time"
                value={formData.check_in_time}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-amber-800 mb-2">Heure de départ</label>
              <input
                type="time"
                name="check_out_time"
                value={formData.check_out_time}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">Notes supplémentaires</label>
              <textarea
                name="additional_notes"
                value={formData.additional_notes}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
            <div className="col-span-2">
              <label className="block text-sm font-medium text-amber-800 mb-2">Méthodes de paiement</label>
              <textarea
                name="payment_methods"
                value={formData.payment_methods}
                onChange={handleChange}
                className="w-full p-2 border border-amber-300 rounded-lg"
              />
            </div>
          </div>
          <div className="flex justify-end gap-4">
            <button
              type="button"
              onClick={onClose}
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              Annuler
            </button>
            <button
              type="submit"
              className="bg-transparent border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-lg"
            >
              {hotel ? "Mettre à jour" : "Créer"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AdminH;
