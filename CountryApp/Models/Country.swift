//
//  CountryElement.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import Foundation
import Foundation

// MARK: - CountryElement
struct CountryElement: Codable {
   
    let name: Name?
    let tld: [String]?
    let cca2, ccn3, cca3, cioc: String?
    let independent: Bool?
    let status: Status?
    let unMember: Bool?
    let currencies: Currencies?
    let idd: Idd?
    let capital, altSpellings: [String]?
    let region: Region?
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let landlocked: Bool?
    let borders: [String]?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let gini: [String: Double]?
    let fifa: String?
    let car: Car?
    let timezones: [String]?
    let continents: [Continent]?
    let flags, coatOfArms: CoatOfArms?
    let startOfWeek: StartOfWeek?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side?
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let mru, awg, ars, sek: Aed?
    let mvr, mxn, nzd, usd: Aed?
    let xpf, eur, pkr, zmw: Aed?
    let scr, myr, nok, uzs: Aed?
    let vuv, aud, sgd, srd: Aed?
    let dzd, mad, crc, lyd: Aed?
    let qar, dkk, mur, kzt: Aed?
    let all, bhd, pgk, bif: Aed?
    let inr, uyu, xcd, bbd: Aed?
    let mop, gbp, imp, syp: Aed?
    let ang, xof, kgs, ttd: Aed?
    let egp, ils, jod, mga: Aed?
    let hrk, fok, htg, ckd: Aed?
    let cuc, cup, twd, szl: Aed?
    let zar, uah, bmd, krw: Aed?
    let pen, iqd, mdl, ves: Aed?
    let gyd, kyd, khr, lkr: Aed?
    let sdg: BAM?
    let ern, sos, kmf, nio: Aed?
    let rub, ugx, chf, tjs: Aed?
    let ssp, czk, bwp, tnd: Aed?
    let jmd, mzn, hnl, azn: Aed?
    let mkd, gmd, lrd, cve: Aed?
    let bsd, gel, kid, tzs: Aed?
    let cny, gtq, stn, sll: Aed?
    let xaf, thb, idr, gip: Aed?
    let tmt, dop, ghs, jep: Aed?
    let currenciesTRY, tvd, irr, kes: Aed?
    let bgn, zwl, aoa, ngn: Aed?
    let pln, shp, lbp, wst: Aed?
    let php, ggp, kwd, top: Aed?
    let omr, afn, rsd, amd: Aed?
    let bdt, lak, clp, pab: Aed?
    let npr, mmk, fkp, huf: Aed?
    let gnf, aed: Aed?
    let bam: BAM?
    let mwk, btn, cdf, vnd: Aed?
    let brl, bzd, pyg, bnd: Aed?
    let bob, djf, cad, jpy: Aed?
    let rwf, isk, byn, hkd: Aed?
    let lsl, fjd, cop, sar: Aed?
    let etb, kpw, nad, mnt: Aed?
    let sbd, yer, ron: Aed?

    enum CodingKeys: String, CodingKey {
        case mru = "MRU"
        case awg = "AWG"
        case ars = "ARS"
        case sek = "SEK"
        case mvr = "MVR"
        case mxn = "MXN"
        case nzd = "NZD"
        case usd = "USD"
        case xpf = "XPF"
        case eur = "EUR"
        case pkr = "PKR"
        case zmw = "ZMW"
        case scr = "SCR"
        case myr = "MYR"
        case nok = "NOK"
        case uzs = "UZS"
        case vuv = "VUV"
        case aud = "AUD"
        case sgd = "SGD"
        case srd = "SRD"
        case dzd = "DZD"
        case mad = "MAD"
        case crc = "CRC"
        case lyd = "LYD"
        case qar = "QAR"
        case dkk = "DKK"
        case mur = "MUR"
        case kzt = "KZT"
        case all = "ALL"
        case bhd = "BHD"
        case pgk = "PGK"
        case bif = "BIF"
        case inr = "INR"
        case uyu = "UYU"
        case xcd = "XCD"
        case bbd = "BBD"
        case mop = "MOP"
        case gbp = "GBP"
        case imp = "IMP"
        case syp = "SYP"
        case ang = "ANG"
        case xof = "XOF"
        case kgs = "KGS"
        case ttd = "TTD"
        case egp = "EGP"
        case ils = "ILS"
        case jod = "JOD"
        case mga = "MGA"
        case hrk = "HRK"
        case fok = "FOK"
        case htg = "HTG"
        case ckd = "CKD"
        case cuc = "CUC"
        case cup = "CUP"
        case twd = "TWD"
        case szl = "SZL"
        case zar = "ZAR"
        case uah = "UAH"
        case bmd = "BMD"
        case krw = "KRW"
        case pen = "PEN"
        case iqd = "IQD"
        case mdl = "MDL"
        case ves = "VES"
        case gyd = "GYD"
        case kyd = "KYD"
        case khr = "KHR"
        case lkr = "LKR"
        case sdg = "SDG"
        case ern = "ERN"
        case sos = "SOS"
        case kmf = "KMF"
        case nio = "NIO"
        case rub = "RUB"
        case ugx = "UGX"
        case chf = "CHF"
        case tjs = "TJS"
        case ssp = "SSP"
        case czk = "CZK"
        case bwp = "BWP"
        case tnd = "TND"
        case jmd = "JMD"
        case mzn = "MZN"
        case hnl = "HNL"
        case azn = "AZN"
        case mkd = "MKD"
        case gmd = "GMD"
        case lrd = "LRD"
        case cve = "CVE"
        case bsd = "BSD"
        case gel = "GEL"
        case kid = "KID"
        case tzs = "TZS"
        case cny = "CNY"
        case gtq = "GTQ"
        case stn = "STN"
        case sll = "SLL"
        case xaf = "XAF"
        case thb = "THB"
        case idr = "IDR"
        case gip = "GIP"
        case tmt = "TMT"
        case dop = "DOP"
        case ghs = "GHS"
        case jep = "JEP"
        case currenciesTRY = "TRY"
        case tvd = "TVD"
        case irr = "IRR"
        case kes = "KES"
        case bgn = "BGN"
        case zwl = "ZWL"
        case aoa = "AOA"
        case ngn = "NGN"
        case pln = "PLN"
        case shp = "SHP"
        case lbp = "LBP"
        case wst = "WST"
        case php = "PHP"
        case ggp = "GGP"
        case kwd = "KWD"
        case top = "TOP"
        case omr = "OMR"
        case afn = "AFN"
        case rsd = "RSD"
        case amd = "AMD"
        case bdt = "BDT"
        case lak = "LAK"
        case clp = "CLP"
        case pab = "PAB"
        case npr = "NPR"
        case mmk = "MMK"
        case fkp = "FKP"
        case huf = "HUF"
        case gnf = "GNF"
        case aed = "AED"
        case bam = "BAM"
        case mwk = "MWK"
        case btn = "BTN"
        case cdf = "CDF"
        case vnd = "VND"
        case brl = "BRL"
        case bzd = "BZD"
        case pyg = "PYG"
        case bnd = "BND"
        case bob = "BOB"
        case djf = "DJF"
        case cad = "CAD"
        case jpy = "JPY"
        case rwf = "RWF"
        case isk = "ISK"
        case byn = "BYN"
        case hkd = "HKD"
        case lsl = "LSL"
        case fjd = "FJD"
        case cop = "COP"
        case sar = "SAR"
        case etb = "ETB"
        case kpw = "KPW"
        case nad = "NAD"
        case mnt = "MNT"
        case sbd = "SBD"
        case yer = "YER"
        case ron = "RON"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String?
}

// MARK: - BAM
struct BAM: Codable {
    let name: String?
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng, fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String?
}

// MARK: - Name
struct Name: Codable {
    let common, official: String?
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String?
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format, regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Country = [CountryElement]
