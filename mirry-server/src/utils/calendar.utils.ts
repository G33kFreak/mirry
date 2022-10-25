const getMonday = () => {
    const today = new Date();
    const first = today.getDate() - today.getDay() + 1;

    const monday = new Date(today.setDate(first));
    monday.setUTCHours(0, 0, 0, 0)

    return monday.toISOString()
}

const getSunday = () => {
    const today = new Date();
    const first = today.getDate() - today.getDay() + 1;
    const last = first + 6;

    const sunday = new Date(today.setDate(last));
    sunday.setUTCHours(23, 59, 59, 999)

    return sunday.toISOString()
}

export {
    getMonday,
    getSunday
}