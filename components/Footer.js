import React from "react";
import Link from "next/link"; // Ajouté pour les liens internes

export default function Footer() {
  return (
    <footer className="bg-gray-800 text-white">
      <div className="mx-auto w-full max-w-screen-xl p-4 py-6 lg:py-8">
        <div className="flex flex-col md:flex-row md:justify-between gap-8">
          {/* Logo et Nom */}
          <div className="mb-6 md:mb-0">
            <a href="/" className="flex items-center space-x-2">
              <svg
                className="w-10 h-10 text-white"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                width="48"
                height="48"
                fill="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  fillRule="evenodd"
                  d="M5 9a7 7 0 1 1 8 6.93V21a1 1 0 1 1-2 0v-5.07A7.001 7.001 0 0 1 5 9Zm5.94-1.06A1.5 1.5 0 0 1 12 7.5a1 1 0 1 0 0-2A3.5 3.5 0 0 0 8.5 9a1 1 0 0 0 2 0c0-.398.158-.78.44-1.06Z"
                  clipRule="evenodd"
                />
              </svg>
              <span className="self-center text-2xl font-semibold whitespace-nowrap font-mono uppercase">
                TRIPDZAIR
              </span>
            </a>
          </div>

          {/* Sections */}
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8 w-full">
            {/* Resources */}
            <div>
              <h2 className="mb-4 text-sm font-semibold text-gray-300 uppercase">
                Ressources
              </h2>
              <ul className="font-medium space-y-3">
                <li>
                  <a href="/" className="hover:underline">
                    Accueil
                  </a>
                </li>
                <li>
                  <a href="/hotels" className="hover:underline">
                    Hôtels
                  </a>
                </li>
                <li>
                  <a href="/restaurant" className="hover:underline">
                    Restaurants
                  </a>
                </li>
                <li>
                  <a href="/activities" className="hover:underline">
                    Activités
                  </a>
                </li>
              </ul>
            </div>

            {/* Je suis */}
            <div>
              <h2 className="mb-4 text-sm font-semibold text-gray-300 uppercase">
                PLUS
              </h2>
              <ul className="font-medium space-y-3">
                <li>
                  <a href="/AdminH" className="hover:underline">
                    Admin Hôtel
                  </a>
                </li>
                <li>
                  <a href="/guide_touristique" className="hover:underline">
                    Guide Touristique
                  </a>
                </li>
                <li>
                  <a href="/ajouterRest" className="hover:underline">
                    Ajouter un Restaurant
                  </a>
                </li>
              </ul>
            </div>

            {/* Contact & Help (remplace Newsletter) */}
            <div>
              <h2 className="mb-4 text-sm font-semibold text-gray-300 uppercase">
                Support
              </h2>
              <ul className="font-medium space-y-3">
                <li>
                  <Link href="/contact" className="hover:underline">
                    Contactez-nous
                  </Link>
                </li>
                <li>
                  <Link href="/help" className="hover:underline">
                    Aide
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </div>

        {/* Ligne de séparation */}
        <hr className="my-6 border-gray-700 sm:mx-auto lg:my-8" />

        {/* Copyright */}
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 text-center">
          <span className="text-sm text-gray-400">
            © 2025 TRIPDZAIR. Tous droits réservés.
          </span>
        </div>
      </div>
    </footer>
  );
}