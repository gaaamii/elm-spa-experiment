module Main exposing (..)

import Html exposing (Html, text, div, h1, img, p)
import Html.Attributes exposing (src)
import Navigation


---- MODEL ----


type alias Model =
    { location : Navigation.Location }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( { location = location }, Cmd.none )



---- UPDATE ----


type Msg
    = UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlChange location ->
      ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , p [] [ text model.location.href ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
