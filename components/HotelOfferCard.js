import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

const HotelOfferCard = ({ hotel }) => {
  const router = useRouter();
  // Détermine si on affiche une offre ou un hôtel
  const isOffer = !!hotel.hotel_offer_id;
  // Pour l'ID, utiliser hotel_offer_id si c'est une offre, sinon hotel_id
  const id = isOffer ? hotel.hotel_offer_id : hotel.hotel_id;

  // États pour le formulaire de réservation (pour les offres)
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [numberOfPeople, setNumberOfPeople] = useState(1);
  const [duration, setDuration] = useState(1);
  const [specialRequest, setSpecialRequest] = useState("");
  const [submissionLoading, setSubmissionLoading] = useState(false);
  const [submissionError, setSubmissionError] = useState(null);
  const [submissionSuccess, setSubmissionSuccess] = useState(null);

  // États pour l'utilisateur connecté
  const [user, setUser] = useState(null);

  // États pour la popup des avis (pour les offres)
  const [showReviewPopup, setShowReviewPopup] = useState(false);
  const [reviews, setReviews] = useState([]);
  const [loadingReviews, setLoadingReviews] = useState(false);
  const [reviewRating, setReviewRating] = useState(5);
  const [reviewComment, setReviewComment] = useState("");
  const [submissionReviewLoading, setSubmissionReviewLoading] = useState(false);
  const [submissionReviewError, setSubmissionReviewError] = useState(null);
  const [submissionReviewSuccess, setSubmissionReviewSuccess] = useState(null);

  // Récupérer l'utilisateur via Supabase Auth pour pré-remplir le formulaire
  useEffect(() => {
    async function fetchUser() {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (user) {
        setUser(user);
        setFirstName(user.user_metadata.first_name || "");
        setLastName(user.user_metadata.last_name || "");
      }
    }
    // Pour une offre, on vérifie l'utilisateur pour pré-remplir le formulaire de réservation
    if (isOffer) {
      fetchUser();
    }
  }, [isOffer]);

  // Gestion de la réservation
  const handleReservationSubmit = async (e) => {
    e.preventDefault();
    setSubmissionLoading(true);
    setSubmissionError(null);
    setSubmissionSuccess(null);

    if (!user) {
      router.push("/auth");
      return;
    }

    // Optionnel : mise à jour du profil utilisateur
    const { error: updateError } = await supabase
      .from("users")
      .update({ first_name: firstName, last_name: lastName })
      .eq("user_id", user.id);
    if (updateError) {
      setSubmissionError("Erreur lors de la mise à jour de votre profil : " + updateError.message);
      setSubmissionLoading(false);
      return;
    }

    const { error } = await supabase
      .from("reservations")
      .insert([
        {
          user_id: user.id,
          reservation_type: isOffer ? "hotel_offer" : "hotel_service",
          reservation_type_id: id,
          number_of_people: Number(numberOfPeople),
          duration: Number(duration),
          special_request: specialRequest,
        },
      ]);
    if (error) {
      setSubmissionError("Erreur lors de la réservation : " + error.message);
    } else {
      setSubmissionSuccess("Votre réservation a bien été enregistrée. Nous allons vous contacter très bientôt.");
      window.location.hash = "";
    }
    setSubmissionLoading(false);
  };

  // Récupération des avis pour l'offre depuis Supabase en joignant la table users pour récupérer le prénom
  const fetchReviews = async () => {
    setLoadingReviews(true);
    const { data, error } = await supabase
      .from("reviews")
      .select("*, users(first_name)")
      .eq("review_type", "hotel_offer")
      .eq("review_type_id", id)
      .order("created_at", { ascending: false });
    if (error) {
      console.error("Erreur lors du chargement des avis:", error.message);
    } else {
      setReviews(data);
    }
    setLoadingReviews(false);
  };

  // Charger les avis dès l'ouverture du popup
  useEffect(() => {
    if (showReviewPopup) {
      fetchReviews();
    }
  }, [showReviewPopup]);

  // Gestion de l'ajout d'un avis
  const handleReviewSubmit = async (e) => {
    e.preventDefault();
    setSubmissionReviewLoading(true);
    setSubmissionReviewError(null);
    setSubmissionReviewSuccess(null);

    if (!user) {
      router.push("/auth");
      return;
    }

    const { error } = await supabase
      .from("reviews")
      .insert([
        {
          user_id: user.id,
          review_type: "hotel_offer",
          review_type_id: id,
          rating: Number(reviewRating),
          comment: reviewComment,
        },
      ]);
    if (error) {
      setSubmissionReviewError("Erreur lors de l'ajout de l'avis: " + error.message);
    } else {
      setSubmissionReviewSuccess("Votre avis a été ajouté.");
      setReviewRating(5);
      setReviewComment("");
      // Recharger les avis pour actualiser la liste
      fetchReviews();
    }
    setSubmissionReviewLoading(false);
  };

  // Fonction de partage (pour les hôtels)
  const handleShare = async () => {
    // Utilise le même lien que "Voir l'hôtel"
    const shareUrl = window.location.origin + `/Hotelaff?hotelId=${id}`;
    const shareData = {
      title: hotel.name,
      text: hotel.description,
      url: shareUrl,
    };
    try {
      if (navigator.share) {
        await navigator.share(shareData);
      } else {
        await navigator.clipboard.writeText(shareUrl);
        alert("Lien copié dans le presse-papiers !");
      }
    } catch (err) {
      console.error("Erreur lors du partage:", err);
    }
  };

  // Fonctions utilitaires d'affichage
  const getLowestPrice = () =>
    hotel.price ? `À partir de ${hotel.price} DZD / nuit` : "Sur demande";

  const displayRating = hotel.star_rating
    ? `${hotel.star_rating} ★`
    : "N/A ★";

  const sentences = hotel.description ? hotel.description.split(". ") : [];
  const truncatedDescription =
    sentences.length > 0
      ? sentences.slice(0, 2).join(". ") + (sentences.length > 2 ? "." : "")
      : "";

  const getAmenities = () => {
    const amenities = [];
    if (hotel.wifi_included) amenities.push("WiFi");
    if (hotel.breakfast_included) amenities.push("Petit-déjeuner");
    if (hotel.lunch_included) amenities.push("Déjeuner");
    if (hotel.dinner_included) amenities.push("Dîner");
    if (hotel.parking_included) amenities.push("Parking");
    if (hotel.pool_access) amenities.push("Piscine");
    if (hotel.gym_access) amenities.push("Gym");
    if (hotel.spa_access) amenities.push("Spa");
    return amenities;
  };

  return (
    <div className="group relative w-[22rem] mb-8">
      <div className="relative overflow-hidden rounded-2xl bg-amber-100 shadow-2xl transition-all duration-300 hover:-translate-y-2 hover:shadow-amber-300/50">
        <div className="absolute -left-16 -top-16 h-32 w-32 rounded-full bg-gradient-to-br from-amber-300/30 to-amber-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>
        <div className="absolute -right-16 -bottom-16 h-32 w-32 rounded-full bg-gradient-to-br from-amber-300/30 to-amber-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>

        <div className="relative p-6">
          {/* Affichage de l'image ou du SVG selon le type */}
          <div className="flex flex-col items-center gap-6">
            <div className="relative flex h-74 w-74 items-center justify-center rounded-2xl bg-white p-2">
              {isOffer ? (
                <svg
                  className="w-[45px] h-[45px] text-gray-800 dark:text-white"
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
                    strokeLinejoin="round"
                    strokeWidth="3"
                    d="M18 17v2M12 5.5V10m-6 7v2m15-2v-4c0-1.6569-1.3431-3-3-3H6c-1.65685 0-3 1.3431-3 3v4h18Zm-2-7V8c0-1.65685-1.3431-3-3-3H8C6.34315 5 5 6.34315 5 8v2h14Z"
                  />
                </svg>
              ) : (
                <img
                  src={hotel.images || "/default-hotel.jpg"}
                  alt={hotel.name}
                  className="h-60 w-65 rounded-xl object-cover"
                  onError={(e) => {
                    e.target.onerror = null;
                    e.target.src = "/default-hotel.jpg";
                  }}
                />
              )}
            </div>
            <div className="text-center">
              <h3 className="text-lg font-semibold text-blue-800">{hotel.name}</h3>
              <p className="text-sm text-slate-400">{hotel.location}</p>
              <p className="mt-4 text-sm text-slate-400">
                {truncatedDescription}
                {sentences.length > 1 && (
                  <a
                    href={`#popup-description-${id}`}
                    className="text-blue-500 underline ml-1"
                  >
                    Voir plus
                  </a>
                )}
              </p>
            </div>
          </div>

          {/* Prix et services / rating */}
          <div className="mt-6 flex justify-center gap-2">
            <span className="inline-flex items-center gap-1 rounded-lg bg-emerald-500/10 px-3 py-1 text-sm text-emerald-500">
              {getLowestPrice()}
            </span>
            {isOffer ? (
              <div className="flex flex-wrap gap-1">
                {getAmenities().map((amenity, idx) => (
                  <span key={idx} className="bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded">
                    {amenity}
                  </span>
                ))}
              </div>
            ) : (
              <span className="inline-flex items-center gap-1 rounded-lg bg-blue-500/10 px-3 py-1 text-sm text-blue-500">
                {displayRating}
              </span>
            )}
          </div>

          {/* Boutons d'action */}
          <div className="mt-8 flex flex-col gap-3">
            {id ? (
              isOffer ? (
                <>
                  <a
                    href={`#popup-reservation-${id}`}
                    onClick={(e) => {
                      if (!user) {
                        e.preventDefault();
                        router.push("/auth");
                      }
                    }}
                    className="flex items-center justify-center gap-2 rounded-xl border border-transparent bg-gradient-to-r from-blue-600 to-blue-500 px-4 py-3 text-white font-semibold transition-all hover:shadow-lg w-full"
                  >
                    Réserver maintenant
                  </a>
                  <button
                    onClick={() => setShowReviewPopup(true)}
                    className="flex items-center justify-center gap-2 rounded-xl border border-blue-600 px-4 py-3 text-blue-600 font-semibold transition-all hover:bg-blue-600/10 w-full"
                  >
                    Voir les avis
                  </button>
                </>
              ) : (
                <>
                  <Link href={`/Hotelaff?hotelId=${id}`}>
                    <button className="flex items-center justify-center gap-2 rounded-xl border border-transparent bg-gradient-to-r from-blue-600 to-blue-500 px-4 py-3 text-white font-semibold transition-all hover:shadow-lg w-full">
                      Voir l'hôtel
                    </button>
                  </Link>
                  <button
                    onClick={handleShare}
                    className="flex items-center justify-center gap-2 rounded-xl border border-amber-500 px-4 py-3 text-amber-500 transition-colors hover:bg-amber-500/10 w-full"
                  >
                    <svg
                      className="w-6 h-6 text-gray-800"
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
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M4 15v2a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3v-2M12 4v12m0-12l4 4m-4-4L8 8"
                      />
                    </svg>
                    Partager
                  </button>
                </>
              )
            ) : (
              <span className="text-red-500">ID non disponible</span>
            )}
          </div>
        </div>
      </div>

      {/* Popup pour la description complète */}
      {sentences.length > 2 && (
        <div id={`popup-description-${id}`} className="popup">
          <div className="popup-content">
            <a href="#" className="close">&times;</a>
            <h3 className="text-lg font-semibold text-blue-800">{hotel.name}</h3>
            <p className="mt-2 text-sm text-slate-400">{hotel.description}</p>
          </div>
          <style jsx>{`
            .popup {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background: rgba(0, 0, 0, 0.7);
              display: none;
              align-items: center;
              justify-content: center;
              z-index: 1000;
            }
            .popup:target {
              display: flex;
            }
            .popup-content {
              background: white;
              padding: 20px;
              border-radius: 8px;
              max-width: 600px;
              width: 90%;
              position: relative;
            }
            .close {
              position: absolute;
              top: 10px;
              right: 10px;
              font-size: 24px;
              text-decoration: none;
              color: #333;
            }
          `}</style>
        </div>
      )}

      {/* Popup de réservation (pour les offres) */}
      {isOffer && (
        <div id={`popup-reservation-${id}`} className="popup">
          <div className="popup-content">
            <a href="#" className="close">&times;</a>
            <h3 className="text-lg font-semibold text-blue-800 mb-4">
              Formulaire de réservation
            </h3>
            <form onSubmit={handleReservationSubmit} className="flex flex-col gap-4">
              <input type="hidden" name="reservation_type" value="hotel_offer" />
              <input type="hidden" name="reservation_type_id" value={id} />
              <div className="flex flex-col">
                <label htmlFor={`first_name_${id}`} className="text-sm font-medium">
                  Nom
                </label>
                <input
                  id={`first_name_${id}`}
                  name="first_name"
                  type="text"
                  value={firstName}
                  onChange={(e) => setFirstName(e.target.value)}
                  required
                  className="p-2 border rounded-md"
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor={`last_name_${id}`} className="text-sm font-medium">
                  Prénom
                </label>
                <input
                  id={`last_name_${id}`}
                  name="last_name"
                  type="text"
                  value={lastName}
                  onChange={(e) => setLastName(e.target.value)}
                  required
                  className="p-2 border rounded-md"
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor={`number_of_people_${id}`} className="text-sm font-medium">
                  Nombre de personnes
                </label>
                <input
                  id={`number_of_people_${id}`}
                  name="number_of_people"
                  type="number"
                  min="1"
                  value={numberOfPeople}
                  onChange={(e) => setNumberOfPeople(e.target.value)}
                  required
                  className="p-2 border rounded-md"
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor={`duration_${id}`} className="text-sm font-medium">
                  Durée (en nuits)
                </label>
                <input
                  id={`duration_${id}`}
                  name="duration"
                  type="number"
                  min="1"
                  value={duration}
                  onChange={(e) => setDuration(e.target.value)}
                  required
                  className="p-2 border rounded-md"
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor={`special_request_${id}`} className="text-sm font-medium">
                  Demande spéciale
                </label>
                <textarea
                  id={`special_request_${id}`}
                  name="special_request"
                  value={specialRequest}
                  onChange={(e) => setSpecialRequest(e.target.value)}
                  placeholder="Vos demandes particulières (optionnel)"
                  className="p-2 border rounded-md"
                ></textarea>
              </div>
              <button
                type="submit"
                disabled={submissionLoading}
                className="bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition-colors"
              >
                {submissionLoading ? "Envoi en cours..." : "Envoyer la réservation"}
              </button>
            </form>
          </div>
          <style jsx>{`
            .popup {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background: rgba(0, 0, 0, 0.7);
              display: none;
              align-items: center;
              justify-content: center;
              z-index: 1000;
            }
            .popup:target {
              display: flex;
            }
            .popup-content {
              background: white;
              padding: 20px;
              border-radius: 8px;
              max-width: 600px;
              width: 90%;
              position: relative;
            }
            .close {
              position: absolute;
              top: 10px;
              right: 10px;
              font-size: 24px;
              text-decoration: none;
              color: #333;
            }
          `}</style>
        </div>
      )}

      {/* Popup des avis pour l'offre */}
      {showReviewPopup && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
          <div className="bg-white rounded-lg shadow-lg max-w-2xl w-full p-6 relative">
            <button
              onClick={() => setShowReviewPopup(false)}
              className="absolute top-4 right-4 text-gray-500 hover:text-gray-700 text-2xl"
            >
              &times;
            </button>
            <h3 className="text-xl font-bold mb-4">Avis pour {hotel.name}</h3>
            {loadingReviews ? (
              <p>Chargement des avis...</p>
            ) : (
              <>
                {reviews.length > 0 ? (
                  <div className="mb-4 max-h-64 overflow-y-auto">
                    {reviews.map((review) => (
                      <div key={review.review_id} className="border-b border-gray-200 pb-2 mb-2">
                        <p className="font-semibold">
                          {review.users && review.users.first_name ? review.users.first_name : "Utilisateur"} : {review.rating} ★
                        </p>
                        <p>{review.comment}</p>
                        <p className="text-xs text-gray-500">
                          {new Date(review.created_at).toLocaleDateString()}
                        </p>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p>Aucun avis disponible.</p>
                )}
              </>
            )}
            <h4 className="text-lg font-semibold mb-2">Ajouter un avis</h4>
            {user ? (
              <>
                {submissionReviewError && <p className="text-red-500 mb-2">{submissionReviewError}</p>}
                {submissionReviewSuccess && <p className="text-green-500 mb-2">{submissionReviewSuccess}</p>}
                <form onSubmit={handleReviewSubmit} className="flex flex-col gap-4">
                  <div className="flex items-center gap-2">
                    <label htmlFor={`review_rating_${id}`} className="w-24">
                      Note:
                    </label>
                    <select
                      id={`review_rating_${id}`}
                      value={reviewRating}
                      onChange={(e) => setReviewRating(e.target.value)}
                      className="border p-2 rounded"
                    >
                      {[1, 2, 3, 4, 5].map((num) => (
                        <option key={num} value={num}>
                          {num}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="flex flex-col">
                    <label htmlFor={`review_comment_${id}`} className="mb-1">
                      Commentaire:
                    </label>
                    <textarea
                      id={`review_comment_${id}`}
                      value={reviewComment}
                      onChange={(e) => setReviewComment(e.target.value)}
                      className="border p-2 rounded"
                      rows="3"
                    ></textarea>
                  </div>
                  <button
                    type="submit"
                    disabled={submissionReviewLoading}
                    className="bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700 transition-colors"
                  >
                    {submissionReviewLoading ? "Envoi en cours..." : "Envoyer l'avis"}
                  </button>
                </form>
              </>
            ) : (
              <p className="text-center text-gray-600">
                Connectez-vous pour ajouter un avis.
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default HotelOfferCard;
