interface CurrentWeather {
    coord: {
        lon: number,
        lat: number,
    },
    weather: {
        id: number,
        main: string,
        description: string,
        icon: string
    }[],
    main: {
        temp: number,
        feels_like: number,
        temp_min: number,
        temp_max: number,
        pressure: number,
        humidity: number,
    },
    wind: {
        speed: number,
        deg: number
    },
    clouds: {
        all: number,
    },
    rain?: {
        '1h': number,
        '3h': number,
    },
    snow?: {
        '1h': number,
        '3h': number,
    },
    sys: {
        sunrise: number,
        sunset: number,
    }
}

export default CurrentWeather