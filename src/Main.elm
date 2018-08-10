module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, img, p, a, ul, li, span)
import Html.Attributes exposing (src, href)
import Html.Events exposing (onClick, onWithOptions, defaultOptions)
import UrlParser exposing (..)
import Navigation
import Json.Decode
import Router


---- MODEL ----


type alias Model =
    { route : Maybe Router.Route }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( { route = parsePath Router.router location }, Cmd.none )



---- UPDATE ----


type Msg
    = UrlChange Navigation.Location
    | PageChange String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            let
                currentRoute =
                    parsePath Router.router location
            in
                ( { model | route = currentRoute }, Cmd.none )

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
        , viewCurrentPage model
        , ul []
            [ li [] [ linkTo "/" "Home" ]
            , li [] [ linkTo "/blog/123" "Blog" ]
            , li [] [ linkTo "/user/hogehoge" "User" ]
            ]
        ]


viewCurrentPage : Model -> Html Msg
viewCurrentPage model =
    case model.route of
        Nothing ->
            viewHome

        Just Router.Home ->
            viewHome

        Just (Router.User userName) ->
            viewUser userName

        Just (Router.Blog id) ->
            viewBlog id


viewHome =
    h2 [] [ text "ホームです" ]


viewBlog id =
    div []
        [ h2 [] [ text "ブログです" ]
        , p []
            [ span [] [ text <| "ID:" ++ (toString id) ]
            ]
        ]


viewUser userName =
    div []
        [ h2 [] [ text "ユーザーです" ]
        , p [] [ text <| "ユーザー名：" ++ userName ]
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
