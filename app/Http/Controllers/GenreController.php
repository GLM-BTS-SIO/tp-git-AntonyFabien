<?php
namespace App\Http\Controllers;
use App\Models\Genre;

class GenreController extends Controller
{
    /**
     * Afficher les genres dans une liste déroulante
     * @return Vue formGenre
     */
    public function getGenres($erreur = "") {
        $genres = Genre::all();
        return view('formGenre', compact('genres', 'erreur'));
    }  
}

