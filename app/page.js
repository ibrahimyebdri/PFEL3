import Header from './components/Header';  // Assure-toi d'avoir un fichier Header.js
import Footer from './components/Footer';  // Assure-toi d'avoir un fichier Footer.js

export default function Page() {
  return (
    <div>
      {/* Appel du composant Header */}
      <Header />

      {/* Contenu principal de la page */}
      <main className="bg-gray-50 min-h-screen">
        <section className="px-6 py-16">
          <div className="max-w-screen-xl mx-auto text-center">
            <h1 className="text-4xl font-semibold text-gray-900 mb-6">
              Bienvenue sur TripDzAir
            </h1>
            <p className="text-lg text-gray-700 mb-8">
              Découvrez nos offres de réservation d'hôtels, restaurants et activités touristiques.
            </p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="border p-4 rounded-lg shadow-lg">
                <h2 className="text-xl font-semibold text-gray-900">Hôtels</h2>
                <p className="text-gray-600 mt-2">
                  Réservez des chambres dans des hôtels de luxe, avec des offres exclusives.
                </p>
              </div>
              <div className="border p-4 rounded-lg shadow-lg">
                <h2 className="text-xl font-semibold text-gray-900">Restaurants</h2>
                <p className="text-gray-600 mt-2">
                  Explorez nos restaurants partenaires pour un repas délicieux.
                </p>
              </div>
              <div className="border p-4 rounded-lg shadow-lg">
                <h2 className="text-xl font-semibold text-gray-900">Activités</h2>
                <p className="text-gray-600 mt-2">
                  Réservez des activités touristiques inoubliables pour votre voyage.
                </p>
              </div>
            </div>
          </div>
        </section>
      </main>

      {/* Appel du composant Footer */}
      <Footer />
    </div>
  );
}
