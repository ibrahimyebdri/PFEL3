"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

const ActivityOfferCard = ({ activity }) => {
  const router = useRouter();

  if (!activity || !activity.tour_announcement_id) {
    console.error("L'objet activity est invalide ou manque tour_announcement_id:", activity);
    return <div className="text-red-500 font-bold text-lg bg-blue-50 p-4 rounded-lg">Erreur : Activité invalide</div>;
  }

  const [user, setUser] = useState(null);
  const [showReviewPopup, setShowReviewPopup] = useState(false);
  const [reviews, setReviews] = useState([]);
  const [loadingReviews, setLoadingReviews] = useState(false);
  const [reviewRating, setReviewRating] = useState(5);
  const [reviewComment, setReviewComment] = useState("");
  const [submissionReviewLoading, setSubmissionReviewLoading] = useState(false);
  const [submissionReviewError, setSubmissionReviewError] = useState(null);
  const [submissionReviewSuccess, setSubmissionReviewSuccess] = useState(null);

  useEffect(() => {
    const fetchUser = async () => {
      const { data: { user }, error } = await supabase.auth.getUser();
      if (error) {
        console.error("Erreur lors de la récupération de l'utilisateur:", error.message);
        return;
      }
      if (user) setUser(user);
    };
    fetchUser();
  }, []);

  const fetchReviews = async () => {
    setLoadingReviews(true);
    const { data, error } = await supabase
      .from("reviews")
      .select("*, users(first_name)")
      .eq("review_type", "tour_activity")
      .eq("review_type_id", activity.tour_announcement_id)
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
        review_type_id: activity.tour_announcement_id,
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

  const handleViewDetails = () => {
    router.push(`/activityaff/${activity.tour_announcement_id}`);
  };

  const handleShare = async () => {
    const shareUrl = `${window.location.origin}/activityaff/${activity.tour_announcement_id}`;
    const shareData = {
      title: activity.name,
      text: activity.description,
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

  const displayDifficulty = activity.difficulty_level || "N/A";
  const displayDuration = activity.duration || "Non spécifiée";
  const truncatedDescription = activity.description ? activity.description.slice(0, 100) + "..." : "";

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

  return (
    <div className="relative w-[22rem] mb-8">
      <div className="relative overflow-hidden rounded-lg bg-blue-50 shadow-lg border border-blue-200 hover:shadow-xl transition-all duration-300">
        {/* Bouton de partage */}
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

        <div className="p-5">
          {/* Image avec badge de réduction */}
          <div className="relative flex h-60 w-full items-center justify-center rounded-lg bg-white border border-blue-100">
            {getDiscountBadge()}
            {activity.images && activity.images !== "" ? (
              <img
                src={activity.images}
                alt={activity.name}
                className="h-full w-full object-cover rounded-lg"
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

          {/* Contenu textuel */}
          <div className="text-center mt-4">
            <h3 className="text-lg font-semibold text-blue-700">{activity.name}</h3>
            <p className="text-sm text-blue-500">{activity.location}</p>
            <p className="mt-2 text-xs text-gray-600">{truncatedDescription}</p>
          </div>

          {/* Informations essentielles */}
          <div className="mt-4 flex flex-col items-center gap-2 text-sm text-gray-700">
            <div className="flex items-center gap-2">
              <span className="font-semibold text-blue-600">Prix :</span>
              <span>{getPrice()}</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="font-semibold text-blue-600">Difficulté :</span>
              <span className="bg-blue-100 px-2 py-1 rounded text-blue-600">{displayDifficulty}</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="font-semibold text-blue-600">Durée :</span>
              <span>{displayDuration}</span>
            </div>
          </div>

          {/* Boutons d'action */}
          <div className="mt-6 flex flex-col gap-3">
            <button
              onClick={handleViewDetails}
              className="flex items-center justify-center gap-2 rounded-xl border bg-blue-600 px-4 py-3 text-white font-semibold hover:bg-blue-700 transition-colors w-full"
            >
              Voir les détails
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

{/* Popup des avis */}
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

      {/* Si l'utilisateur n'est pas connecté */}
      {!user && (
        <p className="text-center text-gray-600">
          <a href="/auth" className="text-blue-600 hover:underline">
            Connectez-vous
          </a>{" "}
          pour voir les commentaires et ajouter un avis !
        </p>
      )}

      {/* Si l'utilisateur est connecté */}
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

          {/* Formulaire pour ajouter un avis */}
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
)}    </div>
  );
};

export default ActivityOfferCard;