import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://axwgziupmlzkyfebumsg.supabase.co'; // Remplace par ton URL Supabase
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_KEY; // Utilise une variable d'environnement pour la clé API
export const supabase = createClient(supabaseUrl, supabaseKey);
