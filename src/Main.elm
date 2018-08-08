module Main exposing (..)

import Html exposing (Html, text, div, h1, img, p, a, ul, li)
import Html.Attributes exposing (src, href)
import Html.Events exposing (onClick, onWithOptions, defaultOptions)
import Navigation
import Json.Decode


---- MODEL ----


type alias Model =
    { location : Navigation.Location }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( { location = location }, Cmd.none )



---- UPDATE ----


type Msg
    = UrlChange Navigation.Location
    | PageChange String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlChange location ->
      ( { model | location = location }, Cmd.none )

    PageChange page ->
      ( model, Navigation.newUrl page )


---- VIEW ----

onPageChange msg =
    onWithOptions
        "click"
        { defaultOptions | preventDefault = True }
        (Json.Decode.succeed msg)

linkTo : String -> String -> Html Msg
linkTo url linkText =
  a [ href url, onPageChange (PageChange url) ] [ text linkText ]

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "SPAの練習" ]
        , p [] [ text model.location.href ]
        , ul []
          [
            li [] [ linkTo "/a" "Aページ" ]
            , li [] [ linkTo "/b" "Bページ" ]
            , li [] [ linkTo "/c" "Cページ" ]
          ]
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
