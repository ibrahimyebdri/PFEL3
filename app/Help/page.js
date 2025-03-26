"use client";

import Header from "@/components/Header";
import Footer from "@/components/Footer";
import Link from "next/link";
import Head from "next/head";

export default function HelpPage() {
  const helpContent = [
    {
      title: "Utilisation de la Plateforme",
      items: [
        {
          question: "Comment réserver une activité ou un hôtel ?",
          answer: "Connectez-vous, trouvez votre choix sur la page principale, et suivez les instructions de réservation.",
        },
        {
          question: "Problème avec mon compte ?",
          answer: "Utilisez l’option 'Mot de passe oublié' ou contactez-nous si vous ne pouvez pas accéder à votre compte.",
        },
      ],
    },
    {
      title: "Devenir Guide Touristique",
      items: [
        {
          question: "Comment m’inscrire comme guide ?",
          answer: (
            <>
              Pour devenir guide touristique, envoyez-nous un message via la{" "}
              <Link href="/contact" className="text-blue-600 underline">
                page Contact
              </Link>
              . Incluez votre expérience (par exemple, années de guidage, régions couvertes) et toute certification pertinente. Nous vous répondrons sous 48h.
            </>
          ),
        },
        {
          question: "Quels sont les critères ?",
          answer: "Une connaissance approfondie d’une région, des compétences en communication, et idéalement une certification de guide touristique.",
        },
      ],
    },
    {
      title: "Devenir Administrateur d’Hôtel",
      items: [
        {
          question: "Comment ajouter mon hôtel ?",
          answer: (
            <>
              Contactez-nous via la{" "}
              <Link href="/contact" className="text-blue-600 underline">
                page Contact
              </Link>
              . Fournissez le nom de votre hôtel, son adresse, et une preuve de gestion (ex. : contrat, licence). Nous vérifierons et activerons votre compte admin.
            </>
          ),
        },
        {
          question: "Documents nécessaires ?",
          answer: "Une pièce d’identité et un document officiel prouvant votre lien avec l’hôtel (ex. : registre commercial).",
        },
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-white text-gray-800">
      <Head>
        <title>Aide | Votre App</title>
        <meta
          name="description"
          content="Guide pour utiliser la plateforme, devenir guide touristique ou administrateur d’hôtel."
        />
      </Head>
      <Header />
      <main className="max-w-4xl mx-auto px-6 py-12">
        {/* Titre principal */}
        <h1 className="text-3xl font-bold mb-8 border-b-2 border-blue-600 pb-2">
          Centre d’Aide
        </h1>

        {/* Sections */}
        {helpContent.map((section, index) => (
          <div key={index} className="mb-8">
            <h2 className="text-2xl font-semibold text-blue-700 mb-4">
              {section.title}
            </h2>
            <div className="space-y-6">
              {section.items.map((item, idx) => (
                <div key={idx} className="border-l-4 border-gray-200 pl-4">
                  <h3 className="text-lg font-medium text-gray-900">
                    {item.question}
                  </h3>
                  <p className="text-gray-700 leading-relaxed">{item.answer}</p>
                </div>
              ))}
            </div>
          </div>
        ))}

        {/* Section finale */}
        <div className="mt-12 text-center bg-gray-100 py-6 rounded-lg">
          <p className="text-gray-600 mb-4">
            Une autre question ? Nous sommes là pour vous aider.
          </p>
          <Link
            href="/contact"
            className="inline-block bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700 transition-colors"
          >
            Nous Contacter
          </Link>
        </div>
      </main>
      <Footer />
    </div>
  );
}