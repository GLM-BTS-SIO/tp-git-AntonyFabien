<?php

namespace App\Http\Controllers;

use Request;
use Exception;
use Session;
use App\Models\Manga;
use App\Models\Genre;
use App\Models\Dessinateur;
use App\Models\Scenariste;

class MangaController extends Controller {

    /**
     * Affiche la liste de tous les Mangas
     * @return Vue listerMangas
     */
    public function getMangas() {
        $erreur = Session::get('erreur');
        Session::forget('erreur');
        // On récupère la liste de tous les mangas
        $mangas = Manga::all();
        // On affiche la liste de ces mangas        
        return view('listeMangas', compact('mangas', 'erreur'));
    }

    /**
     * Afficher la liste des tous les Mangas d'un Genre
     * Si on a sélectionné un genre, on récupère tous les
     * mangas de ce genre et on les affiche
     * Si on n'a pas sélectionné de genre, on construit
     * un message d'erreur et on relance le formulaire 
     * de sélection d'un genre en lui passant le message
     * @return Vue listerMangas
     */
    public function getMangasGenre() {
        $erreur = "";
        // On récupère l'id du genre sélectionné
        $id_genre = Request::input('cbGenre');
        // Si on a un id de genre
        if ($id_genre) {
            // On récupère la liste de tous les mangas du genre choisi
            $mangas = Manga::where('id_genre', $id_genre)->get();
            // On affiche la liste de ces mangas
            return view('listeMangas', compact('mangas', 'erreur'));
        } else {
            $erreur = "Il faut sélectionner un genre !";
            Session::put('erreur', $erreur);
            return redirect('/listerGenres');
        }
    }

    /**
     * Formulaire de modification d'un Manga.
     * Initialise toutes les listes déroulantes
     * Lit le manga à modifier.
     * @param int $id Id du Manga à modifier
     * @param string $erreur message d'erreur (paramètre optionnel)
     * @return Vue formManga
     */
    public function updateManga($id) {
        $erreur = Session::get('erreur');
        Session::forget('erreur');        
        $manga = Manga::find($id);
        $genres = Genre::all();
        $dessinateurs = Dessinateur::all();
        $scenaristes = Scenariste::all();
        $titreVue = "Modification d'un Manga";
        // Affiche le formulaire en lui fournissant les données à afficher
        return view('formManga', compact('manga', 'genres', 'dessinateurs',
                        'scenaristes', 'titreVue', 'erreur'));
    }

    /**
     * Formulaire d'ajout d'un Manga
     * Initialise toutes les listes déroulantes
     * et place le formulaire formManga en mode ajout
     * @return Vue formManga
     */
    public function addManga() {
        $erreur = Session::get('erreur');
        Session::forget('erreur');        
        $manga = new Manga();
        $genres = Genre::all();
        $dessinateurs = Dessinateur::all();
        $scenaristes = Scenariste::all();
        $titreVue = "Ajout d'un Manga";
        // Affiche le formulaire en lui fournissant les données à afficher
        return view('formManga', compact('manga', 'genres', 'dessinateurs', 'scenaristes', 'titreVue', 'erreur'));
    }

    /**
     * Enregistre une mise à jour d'un Manga 
     * Avant d'enregistrer on vérifie que l'utilisateur
     * demandeur a bien le droit de le faire. Si ce n'est
     * pas le cas on propage une Exception qui sera récupérée
     * dans le gestionnaire d'exceptions
     * Si la modification d'un Manga
     * provoque une erreur fatale, on la place
     * dans la Session et on réaffiche le formulaire
     * Sinon réaffiche la liste des mangas
     * @return Redirection listerMangas
     */
    public function validateManga() {
        // Récupération des valeurs saisies
        $id_manga = Request::input('id_manga'); // id dans le champs caché
        $id_dessinateur = Request::input('cbDessinateur'); // Liste déroulante
        $prix = Request::input('prix');
        $id_scenariste = Request::input('cbScenariste'); // Liste déroulante
        $titre = Request::input('titre');
        $id_genre = Request::input('cbGenre'); // Liste déroulante
        // Si on a uploadé une image, il faut la sauvegarder
        // Sinon on récupère le nom dans le champ caché
        if (Request::hasFile('couverture')) {
            $image = Request::file('couverture');
            $couverture = $image->getClientOriginalName();
            Request::file('couverture')->move(base_path() . '/public/images/', $couverture);
        } else {
            $couverture = Request::input('couvertureHidden');
        }
        // Si id_manga est > 0 il faut lire le Manga existant
        // sinon il faut créer une instance de Manga
        if ($id_manga > 0) {
            $manga = Manga::find($id_manga);
        } else {
            $manga = new Manga();
        }
        $manga->titre = $titre;
        $manga->couverture = $couverture;
        $manga->prix = $prix;
        $manga->id_dessinateur = $id_dessinateur;
        $manga->id_scenariste = $id_scenariste;
        $manga->id_genre = $id_genre;
        $manga->id_lecteur = 2;
        $erreur = "";
        try {
            $manga->save();
        } catch (Exception $ex) {
            $erreur = $ex->getMessage();
            Session::put('erreur', $erreur);
            if ($id_manga > 0) {
                return redirect('/modifierManga/' . $id_manga );
            } else {
                return redirect('/ajouterManga/');
            }
        }
        // On réaffiche la liste des mangas
        return redirect('/listerMangas');
    }
    
    /**
     * Supression d'un Manga sur son Id
     * Si la suppression provoque une erreur fatale
     * on la place dans la Session
     * Dans tous les cas on réaffiche la liste des mangas
     * @param int $id : Id du Manga à supprimer
     * @return Redirection listerMangas
     */
    public function deleteManga($id) {
        $erreur = "";
        try {
            $manga = Manga::find($id);
            $manga->delete();
            return redirect('/listerMangas');
        } catch (Exception $ex) {
            Session::put('erreur', $ex->getMessage());
        } finally {
            return redirect('/listerMangas');
        }
    }    

}
