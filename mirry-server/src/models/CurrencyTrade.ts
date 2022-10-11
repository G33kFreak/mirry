import CurrenciesPairs from "./CurrenciesPairs"

interface TradeResultItem {
    vw: number
}

interface TradeResult {
    ticker: CurrenciesPairs,
    resultCount: number,
    results: TradeResultItem[],
}

export default TradeResult