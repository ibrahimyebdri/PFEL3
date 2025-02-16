import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL; 
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY; 

if (!supabaseUrl || !supabaseKey) {
  throw new Error("Supabase URL et clé API manquantes dans les variables d'environnement.");
}

export const supabase = createClient(supabaseUrl, supabaseKey);
