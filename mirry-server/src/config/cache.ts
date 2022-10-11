import NodeCache from "node-cache"

// Periods in seconds
const ONE_DAY_PERIOD = 86400
const ONE_HOUR_PERIOD = 3600

const appCache = new NodeCache({
    stdTTL: ONE_DAY_PERIOD,
    checkperiod: ONE_HOUR_PERIOD
})

export default appCache
export {
    ONE_HOUR_PERIOD
}