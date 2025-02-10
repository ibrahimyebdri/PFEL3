"use client";

import { useState } from "react";
import Header from "../components/Header";
import Footer from "../components/Footer";

export default function AuthPage() {
  const [isLogin, setIsLogin] = useState(true);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [username, setUsername] = useState("");
  const [forgotPassword, setForgotPassword] = useState(false);

  const handleSwitchForm = () => {
    setIsLogin((prev) => !prev);
    setForgotPassword(false);
    setEmail("");
    setPassword("");
    setConfirmPassword("");
    setUsername("");
  };

  const handleForgotPasswordBack = () => {
    setForgotPassword(false);
    setEmail("");
    setPassword("");
  };

  // Styles pour les boutons (Se connecter, S'inscrire, Réinitialiser)
  const buttonStyle =
    "relative inline-flex w-full h-12 active:scale-95 transition-all duration-300 overflow-hidden rounded-lg p-[1px] focus:outline-none";

  const innerButtonStyle = (isSelected) =>
    `inline-flex h-full w-full cursor-pointer items-center justify-center rounded-lg px-6 py-3 text-sm font-medium backdrop-blur-3xl transition-all duration-200 ${
      isSelected
        ? "bg-gray-800 text-gray-400 hover:text-white hover:bg-gray-700"
        : "bg-gray-800 text-gray-400 hover:text-white hover:bg-gray-700"
    }`;

  // Styles pour les champs de texte (moins foncés pour les placeholders)
  const inputStyle =
    "mt-1 p-2 w-full bg-gray-700 border border-gray-600 rounded-md text-white placeholder:text-gray-500"; // Couleur plus claire pour les placeholders

  // Styles pour les boutons de switch (Connexion, Inscription)
  const switchButtonStyle = (isSelected) =>
    `inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-medium transition-all duration-300 border  ${
      isSelected
        ? "bg-gray-600 text-white border-amber-100 h-12" // Taille plus grande quand sélectionné
        : "bg-gray-800 text-gray-400 hover:text-white hover:bg-gray-700 border-gray-700 h-11" // Taille plus petite quand non sélectionné
    }`;

  // Styles pour le bouton Google
  const googleButtonStyle =
    "relative inline-flex w-full h-12 active:scale-95 transition-all duration-300 overflow-hidden rounded-lg p-[1px] focus:outline-none";
  const innerGoogleButtonStyle =
    "inline-flex h-full w-full cursor-pointer items-center justify-center rounded-lg bg-slate-950 px-4 text-sm font-medium text-white backdrop-blur-3xl gap-2 transition-all duration-200 group-hover:bg-[linear-gradient(#e2e2e2,#fefefe)] group-hover:text-blue-600";

  return (
    <div className="bg-gradient-to-r from-teal-500 to-blue-500 min-h-screen">
      <Header />

      <main className="flex items-center justify-center bg-gray-300 min-h-screen">
        <div className="max-w-md w-full mx-auto relative overflow-hidden z-10 bg-gray-800 p-8 rounded-lg shadow-md before:w-24 before:h-24 before:absolute before:bg-purple-600 before:rounded-full before:-z-10 before:blur-2xl after:w-32 after:h-32 after:absolute after:bg-sky-400 after:rounded-full after:-z-10 after:blur-xl after:top-24 after:-right-12">
          {/* Switch Buttons (Connexion, Inscription) */}
          <div className="flex justify-between mb-6 space-x-2">
            <button
              onClick={() => {
                setIsLogin(true);
                setForgotPassword(false);
              }}
              className={switchButtonStyle(isLogin)}
            >
              Connexion
            </button>

            <button
              onClick={() => {
                setIsLogin(false);
                setForgotPassword(false);
              }}
              className={switchButtonStyle(!isLogin)}
            >
              Inscription
            </button>
          </div>

          {/* Formulaire */}
          <form className="space-y-4">
            {forgotPassword ? (
              // Formulaire "Mot de passe oublié"
              <>
                <div>
                  <label
                    htmlFor="email"
                    className="block text-sm font-medium text-gray-300"
                  >
                    Email
                  </label>
                  <input
                    type="email"
                    id="email"
                    className={inputStyle}
                    placeholder="Entrez votre email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>
                <div>
                  {/* Bouton Réinitialiser (Full width) */}
                  <button type="button" className={buttonStyle}>
                    <span
                      className="absolute inset-[-1000%] animate-[spin_2s_linear_infinite] bg-[conic-gradient(from_90deg_at_50%_50%,#e7029a_0%,#f472b6_50%,#bd5fff_100%)]"
                    ></span>
                    <span className={innerButtonStyle(true)}>
                      Réinitialiser le mot de passe
                    </span>
                  </button>
                </div>
                <div className="text-center mt-4">
                  <button
                    type="button"
                    onClick={handleForgotPasswordBack}
                    className="text-teal-500 hover:text-teal-600 focus:outline-none transition-all duration-300"
                  >
                    Retour à la connexion
                  </button>
                </div>
              </>
            ) : (
              // Formulaire de Connexion ou d'Inscription
              <>
                {!isLogin && (
                  <div>
                    <label
                      htmlFor="username"
                      className="block text-sm font-medium text-gray-300"
                    >
                      Nom d'utilisateur
                    </label>
                    <input
                      type="text"
                      id="username"
                      className={inputStyle}
                      placeholder="Entrez votre nom d'utilisateur"
                      value={username}
                      onChange={(e) => setUsername(e.target.value)}
                    />
                  </div>
                )}

                <div>
                  <label
                    htmlFor="email"
                    className="block text-sm font-medium text-gray-300"
                  >
                    Email
                  </label>
                  <input
                    type="email"
                    id="email"
                    className={inputStyle}
                    placeholder="Entrez votre email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>

                <div>
                  <label
                    htmlFor="password"
                    className="block text-sm font-medium text-gray-300"
                  >
                    Mot de passe
                  </label>
                  <input
                    type="password"
                    id="password"
                    className={inputStyle}
                    placeholder="Entrez votre mot de passe"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                </div>

                {!isLogin && (
                  <div>
                    <label
                      htmlFor="confirmPassword"
                      className="block text-sm font-medium text-gray-300"
                    >
                      Confirmer le mot de passe
                    </label>
                    <input
                      type="password"
                      id="confirmPassword"
                      className={inputStyle}
                      placeholder="Confirmez votre mot de passe"
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                    />
                  </div>
                )}

                <div>
                  {/* Bouton Se connecter / S'inscrire (Full width) */}
                  <button type="submit" className={buttonStyle}>
                    <span
                      className="absolute inset-[-1000%] animate-[spin_2s_linear_infinite] bg-[conic-gradient(from_90deg_at_50%_50%,#e7029a_0%,#f472b6_50%,#bd5fff_100%)]"
                    ></span>
                    <span className={innerButtonStyle(isLogin)}>
                      {isLogin ? "Se connecter" : "S'inscrire"}
                    </span>
                  </button>
                </div>

                {isLogin && (
                  <div className="text-center mt-4">
                    <button
                      type="button"
                      onClick={() => setForgotPassword(true)}
                      className="text-teal-500 hover:text-teal-600 focus:outline-none transition-all duration-300"
                    >
                      Mot de passe oublié?
                    </button>
                  </div>
                )}

                <div className="text-center mt-4">
                  <button
                    type="button"
                    onClick={handleSwitchForm}
                    className="text-teal-500 hover:text-teal-600 focus:outline-none transition-all duration-300"
                  >
                    {isLogin
                      ? "Vous n'avez pas de compte? Inscrivez-vous"
                      : "Vous avez déjà un compte? Connectez-vous"}
                  </button>
                </div>
              </>
            )}
          </form>

          {/* Google Sign-in Button */}
          <div className="mt-6">
            <button className={googleButtonStyle}>
              <span
                className="absolute inset-[-1000%] animate-[spin_2s_linear_infinite] bg-[conic-gradient(from_90deg_at_50%_50%,#4285F4_0%,#34A853_25%,#FBBC05_50%,#EA4335_75%,#4285F4_100%)]"
              ></span>
              <span className={innerGoogleButtonStyle}>
                Se connecter avec{" "}
                <span className=" inline-flex">
                  <span style={{ color: "#4285F4" }}>G</span>
                  <span style={{ color: "#DB4437" }}>o</span>
                  <span style={{ color: "#F4B400" }}>o</span>
                  <span style={{ color: "#4285F4" }}>g</span>
                  <span style={{ color: "#0F9D58" }}>l</span>
                  <span style={{ color: "#DB4437" }}>e</span>
                </span>
                <svg
                  stroke="currentColor"
                  fill="currentColor"
                  strokeWidth="0"
                  viewBox="0 0 448 512"
                  height="1em"
                  width="1em"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M429.6 92.1c4.9-11.9 2.1-25.6-7-34.7s-22.8-11.9-34.7-7l-352 144c-14.2 5.8-22.2 20.8-19.3 35.8s16.1 25.8 31.4 25.8H224V432c0 15.3 10.8 28.4 25.8 31.4s30-5.1 35.8-19.3l144-352z"></path>
                </svg>
              </span>
            </button>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
