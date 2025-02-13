const HotelOfferCard = ({ hotel }) => {
  return (
    <div className="group relative w-[22rem] mb-8">
      {/* Conteneur principal */}
      <div className="relative overflow-hidden rounded-2xl bg-amber-100 shadow-2xl transition-all duration-300 hover:-translate-y-2 hover:shadow-amber-300/50">
        <div className="absolute -left-16 -top-16 h-32 w-32 rounded-full bg-gradient-to-br from-amber-300/30 to-amber-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>
        <div className="absolute -right-16 -bottom-16 h-32 w-32 rounded-full bg-gradient-to-br from-amber-300/30 to-amber-100/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>

        <div className="relative p-6">
          {/* Image et informations */}
          <div className="flex flex-col items-center gap-6">
            {/* L'image occupe 1/3 de l'espace */}
            <div className="relative flex h-74 w-74 items-center justify-center rounded-2xl bg-white p-2">
              <img
                src={hotel.image}
                alt={hotel.name}
                className="h-60 w-65 rounded-xl object-cover"
              />
            </div>
            {/* Informations textuelles */}
            <div className="text-center">
              <h3 className="text-lg font-semibold text-blue-800">{hotel.name}</h3>
              <p className="text-sm text-slate-400">{hotel.location}</p>
              {/* Description sous le titre */}
              <p className="mt-4 text-sm text-slate-400">{hotel.description}</p>
            </div>
          </div>

          {/* Prix et évaluation */}
          <div className="mt-6 flex justify-center gap-2">
            <span className="inline-flex items-center gap-1 rounded-lg bg-emerald-500/10 px-3 py-1 text-sm text-emerald-500">
              {hotel.price} DZD / nuit
            </span>
            <span className="inline-flex items-center gap-1 rounded-lg bg-blue-500/10 px-3 py-1 text-sm text-blue-500">
              {hotel.rating} ★
            </span>
          </div>

          {/* Boutons */}
          <div className="mt-8 flex flex-col gap-3">
            <button className="rounded-xl bg-gradient-to-r from-blue-600 to-blue-500 px-4 py-3 text-white font-semibold transition-all hover:shadow-lg">
              Réserver maintenant
            </button>
            <button className="flex items-center justify-center gap-2 rounded-xl border border-amber-500 px-4 py-3 text-amber-500 transition-colors hover:bg-amber-500/10">
              <svg
                className="w-6 h-6 text-gray-800 dark:text-white"
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
              Partager
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HotelOfferCard;
