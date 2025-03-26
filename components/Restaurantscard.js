"use client";

import Link from "next/link";

const RestaurantCard = ({ restaurant }) => {
  // Vérification initiale de l'objet restaurant
  if (!restaurant || !restaurant.restaurant_id) {
    console.error("L'objet restaurant est invalide ou manque restaurant_id:", restaurant);
    return <div className="text-red-500">Erreur : Restaurant invalide</div>;
  }

  // Fonction pour générer les étoiles de notation
  const renderRatingStars = () => {
    const rating = restaurant.star_rating || 0;
    return [...Array(5)].map((_, index) => (
      <span
        key={index}
        className={`text-xl ${
          index < Math.floor(rating) ? "text-yellow-400" : "text-gray-300"
        }`}
      >
        ★
      </span>
    ));
  };

  // SVG par défaut pour l'image si elle ne charge pas
  const defaultSvg = (
    <svg
      className="w-full h-full text-orange-600"
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

  // Gestion du partage
  const handleShare = async () => {
    const shareUrl = `${window.location.origin}/restaurantsaff/${restaurant.restaurant_id}`;
    const shareData = {
      title: restaurant.name,
      text: `Découvrez ${restaurant.name} à ${restaurant.location}`,
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
    <div className="group relative w-[22rem] mb-8">
      <div className="relative overflow-hidden rounded-2xl bg-orange-50 shadow-2xl transition-all duration-300 hover:-translate-y-2 hover:shadow-orange-300/50">
        <div className="absolute -left-16 -top-16 h-32 w-32 rounded-full bg-gradient-to-br from-orange-300/30 to-orange-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>
        <div className="absolute -right-16 -bottom-16 h-32 w-32 rounded-full bg-gradient-to-br from-orange-300/30 to-orange-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>

        {/* Bouton de partage */}
        <button
          onClick={handleShare}
          aria-label="Partager ce restaurant"
          className="absolute top-2 right-2 p-2 bg-orange-200 rounded-full hover:bg-orange-300 transition-colors z-10"
        >
          <svg
            className="w-8 h-8 text-orange-800"
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

        <div className="relative p-6">
          {/* Image avec badge de notation */}
          <div className="relative flex h-74 w-74 items-center justify-center rounded-2xl bg-white p-2">
          
            {restaurant.images && restaurant.images !== "" ? (
              <img
                src={restaurant.images}
                alt={restaurant.name}
                className="h-60 w-65 rounded-xl object-cover"
                onError={(e) => {
                  e.target.style.display = "none";
                  e.target.nextSibling.style.display = "block";
                }}
              />
            ) : null}
            <div
              className="w-full h-full flex items-center justify-center"
              style={{ display: restaurant.images && restaurant.images !== "" ? "none" : "flex" }}
            >
              {defaultSvg}
            </div>
          </div>

          {/* Contenu textuel */}
          <div className="text-center mt-4">
            <h3 className="text-lg font-semibold text-orange-800">{restaurant.name}</h3>
            <p className="text-sm text-orange-400">{restaurant.location}</p>
          </div>

          {/* Informations essentielles */}
          <div className="mt-6 flex flex-col items-center gap-2 text-sm text-gray-700">
            <div className="flex items-center gap-2">
              <span className="font-semibold">Type de cuisine :</span>
              <span className="bg-orange-500/10 px-2 py-1 rounded text-orange-500">
                {restaurant.cuisine_type || "Non spécifié"}
              </span>
            </div>
            <div className="flex items-center gap-2">
              <span className="font-semibold">Note :</span>
              <span>{renderRatingStars()}</span>
            </div>
          </div>

          {/* Bouton d'action */}
          <div className="mt-8 flex flex-col gap-3">
            <Link href={`/restaurantsaff/${restaurant.restaurant_id}`}>
              <button className="flex items-center justify-center gap-2 rounded-xl border border-transparent bg-gradient-to-r from-orange-600 to-orange-500 px-4 py-3 text-white font-semibold transition-all hover:shadow-lg w-full">
                Voir les détails
              </button>
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RestaurantCard;