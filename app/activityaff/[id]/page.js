"use client";

import { useState, useEffect } from "react";
import { useParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

const ActivityDetailPage = () => {
  const { id } = useParams();
  const router = useRouter();
  const [activity, setActivity] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showFullDescription, setShowFullDescription] = useState(false);
  const [showDates, setShowDates] = useState(false);
  const [showReviewPopup, setShowReviewPopup] = useState(false);
  const [user, setUser] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [loadingReviews, setLoadingReviews] = useState(false);
  const [reviewRating, setReviewRating] = useState(5);
  const [reviewComment, setReviewComment] = useState("");
  const [submissionReviewLoading, setSubmissionReviewLoading] = useState(false);
  const [submissionReviewError, setSubmissionReviewError] = useState(null);
  const [submissionReviewSuccess, setSubmissionReviewSuccess] = useState(null);
  const [showReservationPopup, setShowReservationPopup] = useState(false);
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [numberOfPeople, setNumberOfPeople] = useState(1);
  const [specialRequest, setSpecialRequest] = useState("");
  const [submissionLoading, setSubmissionLoading] = useState(false);
  const [submissionError, setSubmissionError] = useState(null);
  const [submissionSuccess, setSubmissionSuccess] = useState(null);
  const [tempMessage, setTempMessage] = useState(null);

  const showTempMessage = (message, type) => {
    setTempMessage({ message, type });
    setTimeout(() => {
      setTempMessage(null);
    }, 4000);
  };

  useEffect(() => {
    const fetchUser = async () => {
      const { data: { user }, error } = await supabase.auth.getUser();
      if (error) {
        console.error("Erreur lors de la récupération de l'utilisateur:", error.message);
        showTempMessage("Erreur d'authentification. Veuillez vous reconnecter.", "error");
        return;
      }
      if (user) {
        console.log("Utilisateur connecté:", user.id, user.email);
        setUser(user);
        const { data, error: userError } = await supabase
          .from("users")
          .select("first_name, last_name, phone_number")
          .eq("user_id", user.id)
          .single();

        if (userError) {
          console.error("Erreur lors de la récupération des informations utilisateur:", userError.message);
        } else if (data) {
          setFirstName(data.first_name || "");
          setLastName(data.last_name || "");
          setPhoneNumber(data.phone_number || "");
        }
      } else {
        console.log("Aucun utilisateur connecté.");
      }
    };
    fetchUser();
  }, []);

  useEffect(() => {
    const fetchActivity = async () => {
      try {
        const { data, error } = await supabase
          .from("tour_announcements")
          .select(`
            *,
            users (
              first_name,
              last_name,
              verified_account
            )
          `)
          .eq("tour_announcement_id", id)
          .single();

        if (error) throw error;
        if (!data) throw new Error("Activité non trouvée");

        setActivity(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    if (id) fetchActivity();
  }, [id]);

  const fetchReviews = async () => {
    setLoadingReviews(true);
    const { data, error } = await supabase
      .from("reviews")
      .select("*, users(first_name)")
      .eq("review_type", "tour_activity")
      .eq("review_type_id", id)
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Erreur lors du chargement des avis:", error.message);
      setReviews([]);
    } else {
      setReviews(data || []);
    }
    setLoadingReviews(false);
  };

  useEffect(() => {
    if (showReviewPopup) fetchReviews();
  }, [showReviewPopup]);

  const handleReviewSubmit = async (e) => {
    e.preventDefault();
    setSubmissionReviewLoading(true);
    setSubmissionReviewError(null);
    setSubmissionReviewSuccess(null);

    if (!user) {
      router.push("/auth");
      setSubmissionReviewLoading(false);
      return;
    }

    const { error } = await supabase
      .from("reviews")
      .insert({
        user_id: user.id,
        review_type: "tour_activity",
        review_type_id: id,
        rating: Number(reviewRating),
        comment: reviewComment || null,
      });

    if (error) {
      setSubmissionReviewError("Erreur lors de l'ajout de l'avis : " + error.message);
    } else {
      setSubmissionReviewSuccess("Avis ajouté avec succès.");
      setReviewRating(5);
      setReviewComment("");
      fetchReviews();
    }
    setSubmissionReviewLoading(false);
  };

  const updateUserInfo = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      const { error } = await supabase
        .from("users")
        .update({
          first_name: firstName,
          last_name: lastName,
          phone_number: phoneNumber,
        })
        .eq("user_id", user.id);

      if (error) {
        console.error("Erreur lors de la mise à jour des informations utilisateur:", error.message);
        return false;
      }
      return true;
    }
    return false;
  };

  const handleReservationSubmit = async (e) => {
    e.preventDefault();
    setSubmissionLoading(true);
    setSubmissionError(null);
    setSubmissionSuccess(null);

    if (!user) {
      showTempMessage("Veuillez vous connecter pour réserver.", "error");
      router.push("/auth");
      setSubmissionLoading(false);
      return;
    }

    console.log("Tentative de réservation - User ID:", user.id);
    console.log("Pour l'activité - Tour Announcement ID:", id);

    const userUpdateSuccess = await updateUserInfo();
    if (!userUpdateSuccess) {
      showTempMessage("Erreur lors de la mise à jour de vos informations.", "error");
      setSubmissionLoading(false);
      return;
    }

    // Création de l'objet réservation avec la référence correcte à l'activité
    const reservationData = {
      user_id: user.id,
      reservation_type: "tour_activity",
      reservation_type_id: id, // ID de l'annonce touristique
      number_of_people: Number(numberOfPeople),
      special_request: specialRequest || "",
      booking_date: new Date().toISOString(),
      payment_status: "pending",
      status: "pending",
      duration: 1
    };

    try {
      // Vérification que l'activité existe avant la réservation
      const { data: activityCheck, error: activityError } = await supabase
        .from("tour_announcements")
        .select("tour_announcement_id")
        .eq("tour_announcement_id", id)
        .single();

      if (activityError || !activityCheck) {
        throw new Error("L'activité n'existe pas");
      }

      // Insertion de la réservation
      const { data, error } = await supabase
        .from("reservations")
        .insert(reservationData)
        .select("reservation_id, user_id, reservation_type_id, number_of_people, status");

      if (error) {
        console.error("Erreur Supabase:", error);
        throw new Error(error.message);
      }

      console.log("Réservation réussie:", data);
      showTempMessage("Réservation enregistrée avec succès!", "success");
      setShowReservationPopup(false);
      setNumberOfPeople(1);
      setSpecialRequest("");
    } catch (err) {
      console.error("Erreur lors de la réservation:", err);
      setSubmissionError(err.message);
      showTempMessage("Erreur: " + err.message, "error");
    } finally {
      setSubmissionLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-screen bg-blue-50">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center py-8 text-red-500 bg-blue-50 min-h-screen">
        Erreur : {error}
      </div>
    );
  }

  const defaultSvg = (
    <svg
      className="w-full h-full text-blue-500"
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

  const profileSvg = (
    <svg
      className="w-8 h-8 text-blue-500"
      aria-hidden="true"
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
    >
      <path
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        d="M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8Zm-6 9v-2a3 3 0 0 1 3-3h6a3 3 0 0 1 3 3v2"
      />
    </svg>
  );

  const description = activity.description || "Aucune description disponible";
  const truncatedDescription = description.length > 150 ? description.slice(0, 150) + "..." : description;

  const formatDates = () => {
    return `Du ${new Date(activity.start_date).toLocaleDateString()} au ${new Date(
      activity.end_date
    ).toLocaleDateString()}`;
  };
  const shortDates = formatDates();
  const fullDatesDetails = `Dates : ${shortDates}\nDurée : ${activity.duration || "Non spécifiée"}`;

  const getPrice = () => {
    if (activity.discount_percentage > 0) {
      return (
        <>
          <span className="line-through text-gray-400 text-sm">{activity.price} DZD</span>
          <span className="ml-2 text-blue-600 font-semibold">{activity.new_price || activity.price} DZD</span>
        </>
      );
    }
    return activity.price ? (
      <span className="text-blue-600 font-semibold">{activity.price} DZD</span>
    ) : (
      <span className="text-blue-500 italic">Sur demande</span>
    );
  };

  const getDiscountBadge = () =>
    activity.discount_percentage > 0 ? (
      <span className="absolute bottom-2 right-2 bg-blue-600 text-white px-2 py-1 rounded-full text-xs font-semibold">
        -{activity.discount_percentage}%
      </span>
    ) : null;

  const handleShare = async () => {
    const shareUrl = `${window.location.origin}/activityaff/${id}`;
    const shareData = {
      title: activity.name || "Activité touristique",
      text: activity.description || "Découvrez cette activité incroyable !",
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

  return (
    <div className="min-h-screen bg-blue-50">
      {tempMessage && (
        <div
          className={`fixed top-4 left-1/2 transform -translate-x-1/2 px-6 py-3 rounded-lg shadow-lg text-white ${
            tempMessage.type === "success" ? "bg-green-500" : "bg-red-500"
          }`}
          style={{ zIndex: 1000 }}
        >
          {tempMessage.message}
        </div>
      )}
      <Header />

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="relative mb-8 rounded-lg overflow-hidden bg-blue-50 border border-blue-200 shadow-lg">
          <button
            onClick={handleShare}
            aria-label="Partager cette activité"
            className="absolute top-2 right-2 p-2 bg-blue-100 rounded-full hover:bg-blue-200 transition-colors z-10"
          >
            <svg
              className="w-6 h-6 text-blue-600"
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
                d="M4 15v2a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3v-2M12 4v12m0-12 4 4m-4-4L8 8"
              />
            </svg>
          </button>
          <div className="relative h-96 flex items-center justify-center bg-white border-b border-blue-100">
            {getDiscountBadge()}
            {activity.images && activity.images !== "" ? (
              <img
                src={activity.images}
                alt={activity.name}
                className="w-full h-full object-cover rounded-t-lg"
                onError={(e) => {
                  e.target.style.display = "none";
                  e.target.nextSibling.style.display = "flex";
                }}
              />
            ) : null}
            <div
              className="w-full h-full flex items-center justify-center"
              style={{ display: activity.images && activity.images !== "" ? "none" : "flex" }}
            >
              {defaultSvg}
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2">
            <h1 className="text-3xl font-semibold text-blue-700 mb-4">{activity.name}</h1>
            <p className="text-sm text-blue-500 mb-4">{activity.location || "Lieu non spécifié"}</p>
            <div className="mb-4">
              <p className="text-sm text-gray-500">
                Publié par {activity?.users?.first_name} {activity?.users?.last_name}
                {activity?.users?.verified_account && (
                  <svg
                    className="w-[28px] h-[28px] text-blue-500 inline-block ml-1"
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
                      d="m8.032 12 1.984 1.984 4.96-4.96m4.55 5.272.893-.893a1.984 1.984 0 0 0 0-2.806l-.893-.893a1.984 1.984 0 0 1-.581-1.403V7.04a1.984 1.984 0 0 0-1.984-1.984h-1.262a1.983 1.983 0 0 1-1.403-.581l-.893-.893a1.984 1.984 0 0 0-2.806 0l-.893.893a1.984 1.984 0 0 1-1.403.581H7.04A1.984 1.984 0 0 0 5.055 7.04v1.262c0 .527-.209 1.031-.581 1.403l-.893.893a1.984 1.984 0 0 0 0 2.806l.893.893c.372.372.581.876.581 1.403v1.262a1.984 1.984 0 0 0 1.984 1.984h1.262c.527 0 1.031.209 1.403.581l.893.893a1.984 1.984 0 0 0 2.806 0l.893-.893a1.985 1.985 0 0 1 1.403-.581h1.262a1.984 1.984 0 0 0 1.984-1.984V15.7c0-.527.209-1.031.581-1.403Z"
                    />
                  </svg>
                )}
              </p>
            </div>
            <p className="text-gray-600 text-base leading-relaxed">
              {showFullDescription ? description : truncatedDescription}
            </p>
            {description.length > 150 && (
              <button
                onClick={() => setShowFullDescription(!showFullDescription)}
                className="text-blue-600 underline text-sm mt-2 hover:text-blue-800 transition-colors"
              >
                {showFullDescription ? "Voir moins" : "Voir plus"}
              </button>
            )}
          </div>

          <div className="bg-blue-50 p-6 rounded-lg border border-blue-200 shadow-lg h-fit sticky top-8">
            <h2 className="text-xl font-semibold text-blue-700 mb-4">Informations pratiques</h2>
            <div className="space-y-4 text-gray-700 text-sm">
              <div>
                <span className="font-semibold text-blue-600">Prix :</span>
                <p>{getPrice()}</p>
              </div>
              <div>
                <span className="font-semibold text-blue-600">Difficulté :</span>
                <p className="bg-blue-100 inline-block px-2 py-1 rounded text-blue-600">
                  {activity.difficulty_level || "N/A"}
                </p>
              </div>
              <div>
                <span className="font-semibold text-blue-600">Dates :</span>
                <p>{showDates ? fullDatesDetails : shortDates}</p>
                {activity.start_date && activity.end_date && (
                  <button
                    onClick={() => setShowDates(!showDates)}
                    className="text-blue-600 underline text-xs hover:text-blue-800 transition-colors"
                  >
                    {showDates ? "Voir moins" : "Voir plus"}
                  </button>
                )}
              </div>
              <div>
                <span className="font-semibold text-blue-600">Participants maximum :</span>
                <p>{activity.max_participants || "Non limité"}</p>
              </div>
              <div>
                <span className="font-semibold text-blue-600">Disponibilité :</span>
                <p className={activity.is_available ? "text-green-600" : "text-red-600"}>
                  {activity.is_available ? "Disponible" : "Complet"}
                </p>
              </div>
            </div>

            <div className="mt-6 flex flex-col gap-3">
              <button
                onClick={() => setShowReservationPopup(true)}
                className="flex items-center justify-center gap-2 rounded-xl border bg-blue-600 px-4 py-3 text-white font-semibold hover:bg-blue-700 transition-colors w-full"
              >
                Réserver maintenant
              </button>
              <button
                onClick={() => setShowReviewPopup(true)}
                className="flex items-center justify-center gap-2 rounded-xl border border-sky-600 px-4 py-3 text-sky-500 transition-colors hover:bg-sky-500/10 w-full"
              >
                Voir les avis
              </button>
            </div>
          </div>
        </div>
      </main>

      {showReviewPopup && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/50 z-50">
          <div className="rounded-lg border-2 bg-slate-300 border-blue-600 max-w-2xl w-full p-6 max-h-[80vh] overflow-y-auto">
            <button
              onClick={() => setShowReviewPopup(false)}
              className="relative top-[-10px] right-[-10px] float-right text-blue-600 hover:text-blue-800 text-2xl font-bold transition-colors"
            >
              ×
            </button>
            <h3 className="text-xl font-semibold text-blue-700 mb-4">Avis pour {activity.name}</h3>

            {!user && (
              <p className="text-center text-gray-600">
                <a href="/auth" className="text-blue-600 hover:underline">
                  Connectez-vous
                </a>{" "}
                pour voir les commentaires et ajouter un avis !
              </p>
            )}

            {user && (
              <>
                {loadingReviews ? (
                  <p className="text-blue-600">Chargement des avis...</p>
                ) : (
                  <>
                    {reviews.length > 0 ? (
                      <div className="mb-6 max-h-60 overflow-y-auto space-y-4">
                        {reviews.map((review) => (
                          <div key={review.review_id} className="flex items-start gap-3 border-b border-blue-200 pb-3">
                            <div>{profileSvg}</div>
                            <div>
                              <p className="font-semibold text-blue-700">
                                {review.users?.first_name || "Utilisateur"} :{" "}
                                <span className="text-yellow-400">{review.rating} ★</span>
                              </p>
                              <p className="text-gray-700 text-sm">{review.comment}</p>
                              <p className="text-xs text-gray-500 italic">
                                {new Date(review.created_at).toLocaleDateString()}
                              </p>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <p className="text-gray-600 mb-4">Aucun avis disponible.</p>
                    )}
                  </>
                )}

                <h4 className="text-lg font-semibold text-blue-700 mb-3">Ajouter un avis</h4>
                {submissionReviewError && (
                  <p className="text-red-500 text-sm mb-3">{submissionReviewError}</p>
                )}
                {submissionReviewSuccess && (
                  <p className="text-green-500 text-sm mb-3">{submissionReviewSuccess}</p>
                )}
                <form onSubmit={handleReviewSubmit} className="flex flex-col gap-4">
                  <div className="flex items-center gap-3">
                    <label
                      htmlFor={`review_rating_${id}`}
                      className="text-sm font-semibold text-blue-700 w-20"
                    >
                      Note :
                    </label>
                    <select
                      id={`review_rating_${id}`}
                      value={reviewRating}
                      onChange={(e) => setReviewRating(e.target.value)}
                      className="border border-blue-300 p-2 rounded-lg w-full"
                    >
                      {[1, 2, 3, 4, 5].map((num) => (
                        <option key={num} value={num}>
                          {num}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="flex flex-col">
                    <label
                      htmlFor={`review_comment_${id}`}
                      className="text-sm font-semibold text-blue-700 mb-1"
                    >
                      Commentaire :
                    </label>
                    <textarea
                      id={`review_comment_${id}`}
                      value={reviewComment}
                      onChange={(e) => setReviewComment(e.target.value)}
                      className="border border-blue-300 p-3 rounded-lg w-full resize-none"
                      rows="3"
                      placeholder="Votre avis..."
                    ></textarea>
                  </div>
                  <button
                    type="submit"
                    disabled={submissionReviewLoading}
                    className="bg-blue-600 text-white py-2 px-4 rounded-lg font-semibold hover:bg-blue-700 transition-colors disabled:bg-gray-400"
                  >
                    {submissionReviewLoading ? "Envoi..." : "Envoyer l'avis"}
                  </button>
                </form>
              </>
            )}
          </div>
        </div>
      )}

      {showReservationPopup && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/50 z-50">
          <div className="rounded-lg border-2 bg-slate-300 border-blue-600 max-w-2xl w-full p-6 max-h-[80vh] overflow-y-auto">
            <button
              onClick={() => setShowReservationPopup(false)}
              className="relative top-[-10px] right-[-10px] float-right text-blue-600 hover:text-blue-800 text-2xl font-bold transition-colors"
            >
              ×
            </button>
            <h3 className="text-xl font-semibold text-blue-700 mb-4">Réservation pour {activity.name}</h3>

            {submissionError && <p className="text-red-500 text-sm mb-3">{submissionError}</p>}
            {submissionSuccess && <p className="text-green-500 text-sm mb-3">{submissionSuccess}</p>}

            <form onSubmit={handleReservationSubmit} className="flex flex-col gap-4">
              <div className="flex flex-col">
                <label htmlFor="first_name" className="text-sm font-semibold text-blue-700 mb-1">
                  Nom :
                </label>
                <input
                  id="first_name"
                  type="text"
                  value={firstName}
                  onChange={(e) => setFirstName(e.target.value)}
                  className="border border-blue-300 p-2 rounded-lg"
                  required
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor="last_name" className="text-sm font-semibold text-blue-700 mb-1">
                  Prénom :
                </label>
                <input
                  id="last_name"
                  type="text"
                  value={lastName}
                  onChange={(e) => setLastName(e.target.value)}
                  className="border border-blue-300 p-2 rounded-lg"
                  required
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor="phone_number" className="text-sm font-semibold text-blue-700 mb-1">
                  Numéro de téléphone :
                </label>
                <input
                  id="phone_number"
                  type="text"
                  value={phoneNumber}
                  onChange={(e) => setPhoneNumber(e.target.value)}
                  className="border border-blue-300 p-2 rounded-lg"
                  required
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor="number_of_people" className="text-sm font-semibold text-blue-700 mb-1">
                  Nombre de personnes :
                </label>
                <input
                  id="number_of_people"
                  type="number"
                  min="1"
                  value={numberOfPeople}
                  onChange={(e) => setNumberOfPeople(e.target.value)}
                  className="border border-blue-300 p-2 rounded-lg"
                  required
                />
              </div>
              <div className="flex flex-col">
                <label htmlFor="special_request" className="text-sm font-semibold text-blue-700 mb-1">
                  Demande spéciale :
                </label>
                <textarea
                  id="special_request"
                  value={specialRequest}
                  onChange={(e) => setSpecialRequest(e.target.value)}
                  className="border border-blue-300 p-2 rounded-lg"
                  rows="3"
                  placeholder="Vos demandes particulières (optionnel)"
                ></textarea>
              </div>
              <button
                type="submit"
                disabled={submissionLoading}
                className="bg-blue-600 text-white py-2 px-4 rounded-lg font-semibold hover:bg-blue-700 transition-colors disabled:bg-gray-400"
              >
                {submissionLoading ? "Envoi..." : "Réserver"}
              </button>
            </form>
          </div>
        </div>
      )}

      <Footer />
    </div>
  );
};

export default ActivityDetailPage;