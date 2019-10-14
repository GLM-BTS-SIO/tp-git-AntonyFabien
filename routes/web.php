<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('home');
});
// Afficher la liste de tous les Mangas
Route::get('/listerMangas', 'MangaController@getMangas');
// Lister tous les mangas d'un genre sélectionné
Route::post('/listerMangasGenre', 'MangaController@getMangasGenre');
// Afficher la liste déroulante des genres
Route::get('/listerGenres', 'GenreController@getGenres');
// Afficher un manga pour pouvoir éventuellement le modifier    
Route::get('/modifierManga/{id}', 'MangaController@updateManga');
// Enregistrer la mise à jour d'un  manga
Route::post('/validerManga', 'MangaController@validateManga');
// Afficher le formulaire de saisie d'un nouveau manga
Route::get('/ajouterManga', 'MangaController@addManga');
// Supprimer un manga
Route::get('/supprimerManga/{id}', 'MangaController@deleteManga');
