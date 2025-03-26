"use client";

import Header from "@/components/Header";
import Footer from "@/components/Footer";
import Head from "next/head";

export default function ContactPage() {
  return (
    <div className="min-h-screen bg-gray-100">
      <Head>
        <title>Contactez-nous | Votre App</title>
        <meta
          name="description"
          content="Contactez-nous via email ou nos réseaux sociaux."
        />
      </Head>
      <Header />
      <main className="container mx-auto p-8">
        <h1 className="text-3xl font-bold text-gray-800 mb-6 text-center">
          Contactez-nous
        </h1>
        <div className="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg text-center">
          <p className="text-gray-700 mb-6">
            Nous sommes disponibles pour répondre à vos questions ! Choisissez votre moyen préféré pour nous contacter :
          </p>

          {/* Email */}
          <div className="mb-6">
            <h2 className="text-xl font-semibold text-gray-800">Par Email</h2>
            <p className="text-gray-600 mt-2">
              Envoyez-nous un message à :{" "}
              <a
                href="mailto:support@votreapp.com"
                className="text-indigo-600 hover:underline"
              >
                support@votreapp.com
              </a>
            </p>
          </div>

          {/* Réseaux Sociaux avec icônes Flowbite */}
          <div>
            <h2 className="text-xl font-semibold text-gray-800">
              Sur les Réseaux Sociaux
            </h2>
            <div className="mt-4 flex justify-center gap-6">
              {/* Twitter (Flowbite Icon) */}
              <a
                href="https://twitter.com/votreapp"
                target="_blank"
                rel="noopener noreferrer"
                className="text-indigo-600 hover:text-indigo-800 transition-colors"
              >
                <svg
                  className="w-8 h-8"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M18.205 2.25h3.308l-7.227 8.26 8.502 11.24h-6.648l-5.214-6.817-5.97 6.817H1.643l7.665-8.755-8.058-10.745h6.829l4.713 6.231 5.413-6.231Zm-1.161 17.52h1.833L7.045 4.126H5.078L16.044 19.77Z" />
                </svg>
                <span className="sr-only">Twitter</span>
              </a>

              {/* Facebook (Flowbite Icon) */}
              <a
                href="https://facebook.com/votreapp"
                target="_blank"
                rel="noopener noreferrer"
                className="text-indigo-600 hover:text-indigo-800 transition-colors"
              >
                <svg
                  className="w-8 h-8"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M13.001 22v-9h3l.5-3h-3.5V7.5c0-.831.669-1.5 1.5-1.5h2V3h-2c-2.485 0-4.5 2.015-4.5 4.5V10h-3v3h3v9h3Z" />
                </svg>
                <span className="sr-only">Facebook</span>
              </a>

            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}