"use client";

import Header from "./components/Header";
import Footer from "./components/Footer";
import Carousel from "./components/Carousel";
import HotelOfferCard from "./components/HotelOfferCard";

const hotels = [
  {
    id: 1,
    name: "Hôtel El Aurassi",
    location: "Alger, Algérie",
    price: "20,000 DZD / nuit",
    rating: 4.5,
    image: "https://www.leguidetouristique.com/wp-content/uploads/2022/02/parc-ahaggar-1024x684.jpg ",
    description: "Un hôtel 5 étoiles offrant une vue imprenable sur la baie d'Alger."
  },
  {
    id: 2,
    name: "Hôtel Sheraton Club des Pins",
    location: "Alger, Algérie",
    price: "25,000 DZD / nuit",
    rating: 4.7,
    image: "/images/sheraton.jpg",
    description: "Un resort luxueux en bord de mer avec des équipements modernes."
  },
  {
    id: 3,
    name: "Hôtel Constantine Marriott",
    location: "Constantine, Algérie",
    price: "18,000 DZD / nuit",
    rating: 4.6,
    image: "/images/marriott.jpg",
    description: "Un hébergement de prestige avec une architecture élégante."
  }
];

export default function Page() {
  return (
    <div>
      <Header />

      <main className="bg-gray-50">
        <div className="relative">
          <Carousel />

          <div
            className="absolute left-1/2 transform -translate-x-1/2
                       top-[70%] sm:top-auto sm:bottom-[-40px] z-20
                       w-[90%] max-w-3xl"
          >
            <div className="bg-white/30 backdrop-blur-md rounded-xl p-6 shadow-2xl">
              <form className="flex flex-col sm:flex-row items-center gap-4">
                <div className="w-full">
                  <label htmlFor="destination" className="text-blue-200 font-medium">
                    Où allez-vous ?
                  </label>
                  <input
                    id="destination"
                    type="text"
                    placeholder="Entrez une destination"
                    className="w-full p-3 mt-1 rounded-lg border border-white/50 bg-white/20
                               placeholder-gray-700 text-gray-700 focus:outline-none focus:ring-2 focus:ring-white/70"
                  />
                </div>

                <div className="w-full relative">
                  <label htmlFor="arrivee-date" className="text-blue-200 font-medium">
                    Date d'arrivée
                  </label>
                  <input
                    id="arrivee-date"
                    type="date"
                    className="w-full p-3 mt-1 rounded-lg border border-white/50 bg-white/20 text-gray-700
                               focus:outline-none focus:ring-2 focus:ring-white/70"
                  />
                </div>

                <button
                  type="submit"
                  className="w-full sm:w-auto bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition-colors"
                >
                  Rechercher
                </button>
              </form>
            </div>
          </div>
        </div>

        <section className="px-6 py-16 mt-20">
          <div className="max-w-screen-xl mx-auto text-center">
            <p className="text-lg text-gray-700 mb-8">
              Découvrez nos offres de réservation d'hôtels en Algérie.
            </p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {hotels.map((hotel) => (
                <HotelOfferCard key={hotel.id} hotel={hotel} />
              ))}
            </div>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}
