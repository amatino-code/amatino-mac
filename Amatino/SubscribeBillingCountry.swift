//
//  SubscribeBillingCountry.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class SubscribeBillingCountry {
    
    let set = BillingCountrySet([
        BillingCountry("Afghanistan", 1),
        BillingCountry("Albania", 2),
        BillingCountry("Algeria", 3),
        BillingCountry("American Samoa", 4),
        BillingCountry("Andorra", 5),
        BillingCountry("Angola", 6),
        BillingCountry("Anguilla", 7),
        BillingCountry("Antigua and Barbuda", 8),
        BillingCountry("Argentina", 9),
        BillingCountry("Armenia", 10),
        BillingCountry("Aruba", 11),
        BillingCountry("Australia", 12, Decimal(string: "0.1")!),
        BillingCountry("Austria", 13),
        BillingCountry("Azerbaijan", 14),
        BillingCountry("Bahamas", 15),
        BillingCountry("Bahrain", 16),
        BillingCountry("Bangladesh", 17),
        BillingCountry("Barbados", 18),
        BillingCountry("Belarus", 19),
        BillingCountry("Belgium", 20),
        BillingCountry("Belize", 21),
        BillingCountry("Benin", 22),
        BillingCountry("Bermuda", 23),
        BillingCountry("Bhutan", 24),
        BillingCountry("Bolivia", 25),
        BillingCountry("Bosnia and Herzegovina", 26),
        BillingCountry("Botswana", 27),
        BillingCountry("Brazil", 28),
        BillingCountry("British Virgin Islands", 29),
        BillingCountry("Brunei", 30),
        BillingCountry("Bulgaria", 31),
        BillingCountry("Burkina Faso", 32),
        BillingCountry("Burundi", 33),
        BillingCountry("Côte d'Ivoire", 34),
        BillingCountry("Cabo Verde", 35),
        BillingCountry("Cambodia", 36),
        BillingCountry("Cameroon", 37),
        BillingCountry("Canada", 38),
        BillingCountry("Caribbean Netherlands", 39),
        BillingCountry("Cayman Islands", 40),
        BillingCountry("Central African Republic", 41),
        BillingCountry("Chad", 42),
        BillingCountry("Channel Islands", 43),
        BillingCountry("Chile", 44),
        BillingCountry("China", 45),
        BillingCountry("Colombia", 46),
        BillingCountry("Comoros", 47),
        BillingCountry("Congo (Congo-Brazzaville)", 48),
        BillingCountry("Cook Islands", 49),
        BillingCountry("Costa Rica", 50),
        BillingCountry("Croatia", 51),
        BillingCountry("Cuba", 52),
        BillingCountry("Curaçao", 53),
        BillingCountry("Cyprus", 54),
        BillingCountry("Czech Republic", 55),
        BillingCountry("Democratic Republic of the Congo", 56),
        BillingCountry("Denmark", 57),
        BillingCountry("Djibouti", 58),
        BillingCountry("Dominica", 59),
        BillingCountry("Dominican Republic", 60),
        BillingCountry("Ecuador", 61),
        BillingCountry("Egypt", 62),
        BillingCountry("El Salvador", 63),
        BillingCountry("Equatorial Guinea", 64),
        BillingCountry("Eritrea", 65),
        BillingCountry("Estonia", 66),
        BillingCountry("Ethiopia", 67),
        BillingCountry("Faeroe Islands", 68),
        BillingCountry("Falkland Islands (Islas Malvinas)", 69),
        BillingCountry("Fiji", 70),
        BillingCountry("Finland", 71),
        BillingCountry("France", 72),
        BillingCountry("French Guiana", 73),
        BillingCountry("French Polynesia", 74),
        BillingCountry("Gabon", 75),
        BillingCountry("Gambia", 76),
        BillingCountry("Georgia", 77),
        BillingCountry("Germany", 78),
        BillingCountry("Ghana", 79),
        BillingCountry("Gibraltar", 80),
        BillingCountry("Greece", 81),
        BillingCountry("Greenland", 82),
        BillingCountry("Grenada", 83),
        BillingCountry("Guadeloupe", 84),
        BillingCountry("Guam", 85),
        BillingCountry("Guatemala", 86),
        BillingCountry("Guinea", 87),
        BillingCountry("Guinea-Bissau", 88),
        BillingCountry("Guyana", 89),
        BillingCountry("Haiti", 90),
        BillingCountry("Holy See", 91),
        BillingCountry("Honduras", 92),
        BillingCountry("Hong Kong (S.A.R. of China)", 93),
        BillingCountry("Hungary", 94),
        BillingCountry("Iceland", 95),
        BillingCountry("India", 96),
        BillingCountry("Indonesia", 97),
        BillingCountry("Iran", 98),
        BillingCountry("Iraq", 99),
        BillingCountry("Ireland", 100),
        BillingCountry("Isle of Man", 101),
        BillingCountry("Israel", 102),
        BillingCountry("Italy", 103),
        BillingCountry("Jamaica", 104),
        BillingCountry("Japan", 105),
        BillingCountry("Jordan", 106),
        BillingCountry("Kazakhstan", 107),
        BillingCountry("Kenya", 108),
        BillingCountry("Kiribati", 109),
        BillingCountry("Kuwait", 110),
        BillingCountry("Kyrgyzstan", 111),
        BillingCountry("Laos", 112),
        BillingCountry("Latvia", 113),
        BillingCountry("Lebanon", 114),
        BillingCountry("Lesotho", 115),
        BillingCountry("Liberia", 116),
        BillingCountry("Libya", 117),
        BillingCountry("Liechtenstein", 118),
        BillingCountry("Lithuania", 119),
        BillingCountry("Luxembourg", 120),
        BillingCountry("Macao (S.A.R. of China)", 121),
        BillingCountry("Macedonia (FYROM)", 122),
        BillingCountry("Madagascar", 123),
        BillingCountry("Malawi", 124),
        BillingCountry("Malaysia", 125),
        BillingCountry("Maldives", 126),
        BillingCountry("Mali", 127),
        BillingCountry("Malta", 128),
        BillingCountry("Marshall Islands", 129),
        BillingCountry("Martinique", 130),
        BillingCountry("Mauritania", 131),
        BillingCountry("Mauritius", 132),
        BillingCountry("Mayotte", 133),
        BillingCountry("Mexico", 134),
        BillingCountry("Micronesia", 135),
        BillingCountry("Moldova", 136),
        BillingCountry("Monaco", 137),
        BillingCountry("Mongolia", 138),
        BillingCountry("Montenegro", 139),
        BillingCountry("Montserrat", 140),
        BillingCountry("Morocco", 141),
        BillingCountry("Mozambique", 142),
        BillingCountry("Myanmar (formerly Burma)", 143),
        BillingCountry("Namibia", 144),
        BillingCountry("Nauru", 145),
        BillingCountry("Nepal", 146),
        BillingCountry("Netherlands", 147),
        BillingCountry("New Caledonia", 148),
        BillingCountry("New Zealand", 149),
        BillingCountry("Nicaragua", 150),
        BillingCountry("Niger", 151),
        BillingCountry("Nigeria", 152),
        BillingCountry("Niue", 153),
        BillingCountry("North Korea", 154),
        BillingCountry("Northern Mariana Islands", 155),
        BillingCountry("Norway", 156),
        BillingCountry("Oman", 157),
        BillingCountry("Pakistan", 158),
        BillingCountry("Palau", 159),
        BillingCountry("Palestine State", 160),
        BillingCountry("Panama", 161),
        BillingCountry("Papua New Guinea", 162),
        BillingCountry("Paraguay", 163),
        BillingCountry("Peru", 164),
        BillingCountry("Philippines", 165),
        BillingCountry("Poland", 166),
        BillingCountry("Portugal", 167),
        BillingCountry("Puerto Rico", 168),
        BillingCountry("Qatar", 169),
        BillingCountry("Réunion", 170),
        BillingCountry("Romania", 171),
        BillingCountry("Russia", 172),
        BillingCountry("Rwanda", 173),
        BillingCountry("Saint Helena", 174),
        BillingCountry("Saint Kitts and Nevis", 175),
        BillingCountry("Saint Lucia", 176),
        BillingCountry("Saint Pierre and Miquelon", 177),
        BillingCountry("Saint Vincent and the Grenadines", 178),
        BillingCountry("Samoa", 179),
        BillingCountry("San Marino", 180),
        BillingCountry("Sao Tome and Principe", 181),
        BillingCountry("Saudi Arabia", 182),
        BillingCountry("Senegal", 183),
        BillingCountry("Serbia", 184),
        BillingCountry("Seychelles", 185),
        BillingCountry("Sierra Leone", 186),
        BillingCountry("Singapore", 187),
        BillingCountry("Sint Maarten", 188),
        BillingCountry("Slovakia", 189),
        BillingCountry("Slovenia", 190),
        BillingCountry("Solomon Islands", 191),
        BillingCountry("Somalia", 192),
        BillingCountry("South Africa", 193),
        BillingCountry("South Korea", 194),
        BillingCountry("South Sudan", 195),
        BillingCountry("Spain", 196),
        BillingCountry("Sri Lanka", 197),
        BillingCountry("Sudan", 198),
        BillingCountry("Suriname", 199),
        BillingCountry("Swaziland", 200),
        BillingCountry("Sweden", 201),
        BillingCountry("Switzerland", 202),
        BillingCountry("Syria", 203),
        BillingCountry("Taiwan", 204),
        BillingCountry("Tajikistan", 205),
        BillingCountry("Tanzania", 206),
        BillingCountry("Thailand", 207),
        BillingCountry("Timor-Leste", 208),
        BillingCountry("Togo", 209),
        BillingCountry("Tokelau", 210),
        BillingCountry("Tonga", 211),
        BillingCountry("Trinidad and Tobago", 212),
        BillingCountry("Tunisia", 213),
        BillingCountry("Turkey", 214),
        BillingCountry("Turkmenistan", 215),
        BillingCountry("Turks and Caicos Islands", 216),
        BillingCountry("Tuvalu", 217),
        BillingCountry("Uganda", 218),
        BillingCountry("Ukraine", 219),
        BillingCountry("United Arab Emirates", 220),
        BillingCountry("United Kingdom", 221),
        BillingCountry("United States of America", 222),
        BillingCountry("United States Virgin Islands", 223),
        BillingCountry("Uruguay", 224),
        BillingCountry("Uzbekistan", 225),
        BillingCountry("Vanuatu", 226),
        BillingCountry("Venezuela", 227),
        BillingCountry("Viet Nam", 228),
        BillingCountry("Wallis and Futuna Islands", 229),
        BillingCountry("Western Sahara", 230),
        BillingCountry("Yemen", 231),
        BillingCountry("Zambia", 232),
        BillingCountry("Zimbabwe", 233)
    ])
    
}

