const HotelOfferCard = ({ hotel }) => {
  return (
    <div className="group relative w-[22rem] mb-8"> {/* Largeur réduite à 22rem */}
      <div className="relative overflow-hidden rounded-2xl bg-slate-950 shadow-2xl transition-all duration-300 hover:-translate-y-2 hover:shadow-emerald-500/10">
        <div className="absolute -left-16 -top-16 h-32 w-32 rounded-full bg-gradient-to-br from-emerald-500/20 to-teal-500/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>
        <div className="absolute -right-16 -bottom-16 h-32 w-32 rounded-full bg-gradient-to-br from-blue-500/20 to-indigo-500/0 blur-2xl transition-all duration-500 group-hover:scale-150 group-hover:opacity-70"></div>

        <div className="relative p-6">
          {/* Image et informations */}
          <div className="flex flex-col items-center sm:flex-row sm:items-start gap-6">
            <div className="relative flex h-32 w-32 items-center justify-center rounded-2xl bg-white p-2">
              <img src={hotel.image} alt={hotel.name} className="h-28 w-28 rounded-xl object-cover" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-semibold text-white">{hotel.name}</h3>
              <p className="text-sm text-slate-400">{hotel.location}</p>
              {/* Description sous le titre */}
              <p className="mt-4 text-sm text-slate-400">{hotel.description}</p>
            </div>
          </div>

          {/* Prix et évaluation */}
          <div className="mt-6 flex flex-wrap gap-2">
            <span className="inline-flex items-center gap-1 rounded-lg bg-emerald-500/10 px-3 py-1 text-sm text-emerald-500">
              ${hotel.price} / nuit
            </span>
            <span className="inline-flex items-center gap-1 rounded-lg bg-blue-500/10 px-3 py-1 text-sm text-blue-500">
              {hotel.rating} ★
            </span>
          </div>

          {/* Boutons */}
          <div className="mt-8 flex gap-3">
            <button className="flex-1 rounded-xl bg-gradient-to-r from-emerald-500 to-teal-500 px-4 py-3 text-white font-semibold transition-all hover:shadow-lg">
              Réserver maintenant
            </button>
            <button className="flex items-center justify-center gap-2 rounded-xl bg-slate-900 px-4 py-3 text-white transition-colors hover:bg-slate-800">
              <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z" />
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