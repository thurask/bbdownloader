function ri() {
    var e = new Array;
    var t = unescape("%61%62%63%64%65%66%67%68%69%6A%6B%6C%6D%6E%6F%70%71%72%73%74%75%76%77%78%79%7A");
    var n = 0;
    for (n = 0; n < t.length; n++) e[t.charAt(n)] = t.charAt((n + 13) % 26);
    for (n = 0; n < t.length; n++) e[t.charAt(n).toUpperCase()] = t.charAt((n + 13) % 26).toUpperCase();
    return e;
}

function r(e) {
    var t;
    if (!t) t = ri();
    var n = "";
    var r = 0;
    for (r = 0; r < e.length; r++) {
        var i = e.charAt(r);
        n += i >= "A" && i <= "Z" || i >= "a" && i <= "z" ? t[i] : i;
    }
    return n;
}

function jsSHA(e, t) {
    jsSHA.charSize = 8;
    jsSHA.b64pad = "";
    jsSHA.hexCase = 0;
    var n = null;
    var r = function(e) {
        var t = [];
        var n = (1 << jsSHA.charSize) - 1;
        var r = e.length * jsSHA.charSize;
        for (var i = 0; i < r; i += jsSHA.charSize) {
            t[i >> 5] |= (e.charCodeAt(i / jsSHA.charSize) & n) << 32 - jsSHA.charSize - i % 32;
        }
        return t;
    };
    var i = function(e) {
        var t = [];
        var n = e.length;
        for (var r = 0; r < n; r += 2) {
            var i = parseInt(e.substr(r, 2), 16);
            if (!isNaN(i)) {
                t[r >> 3] |= i << 24 - 4 * (r % 8);
            } else {
                return "INVALID HEX STRING";
            }
        }
        return t;
    };
    var s = null;
    var o = null;
    if ("HEX" === t) {
        if (0 !== e.length % 2) {
            return "TEXT MUST BE IN BYTE INCREMENTS";
        }
        s = e.length * 4;
        o = i(e);
    } else if ("ASCII" === t || "undefined" === typeof t) {
        s = e.length * jsSHA.charSize;
        o = r(e);
    } else {
        return "UNKNOWN TEXT INPUT TYPE";
    }
    var u = function(e) {
        var t = jsSHA.hexCase ? "0123456789ABCDEF" : "0123456789abcdef";
        var n = "";
        var r = e.length * 4;
        for (var i = 0; i < r; i++) {
            n += t.charAt(e[i >> 2] >> (3 - i % 4) * 8 + 4 & 15) + t.charAt(e[i >> 2] >> (3 - i % 4) * 8 & 15);
        }
        return n;
    };
    var a = function(e) {
        var t = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var n = "";
        var r = e.length * 4;
        for (var i = 0; i < r; i += 3) {
            var s = (e[i >> 2] >> 8 * (3 - i % 4) & 255) << 16 | (e[i + 1 >> 2] >> 8 * (3 - (i + 1) % 4) & 255) << 8 | e[i + 2 >> 2] >> 8 * (3 - (i + 2) % 4) & 255;
            for (var o = 0; o < 4; o++) {
                if (i * 8 + o * 6 > e.length * 32) {
                    n += jsSHA.b64pad;
                } else {
                    n += t.charAt(s >> 6 * (3 - o) & 63);
                }
            }
        }
        return n;
    };
    var f = function(e, t) {
        if (t < 32) {
            return e << t | e >>> 32 - t;
        } else {
            return e;
        }
    };
    var l = function(e, t, n) {
        return e ^ t ^ n;
    };
    var c = function(e, t, n) {
        return e & t ^ ~e & n;
    };
    var h = function(e, t, n) {
        return e & t ^ e & n ^ t & n;
    };
    var p = function(e, t) {
        var n = (e & 65535) + (t & 65535);
        var r = (e >>> 16) + (t >>> 16) + (n >>> 16);
        return (r & 65535) << 16 | n & 65535;
    };
    var d = function(e, t, n, r, i) {
        var s = (e & 65535) + (t & 65535) + (n & 65535) + (r & 65535) + (i & 65535);
        var o = (e >>> 16) + (t >>> 16) + (n >>> 16) + (r >>> 16) + (i >>> 16) + (s >>> 16);
        return (o & 65535) << 16 | s & 65535;
    };
    var v = function(e, t) {
        var n = [];
        var r, i, s, o, u;
        var a;
        var v = [1732584193, 4023233417, 2562383102, 271733878, 3285377520];
        var m = [1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1518500249, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 1859775393, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 2400959708, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782, 3395469782];
        e[t >> 5] |= 128 << 24 - t % 32;
        e[(t + 1 + 64 >> 9 << 4) + 15] = t;
        var g = e.length;
        for (var y = 0; y < g; y += 16) {
            r = v[0];
            i = v[1];
            s = v[2];
            o = v[3];
            u = v[4];
            for (var b = 0; b < 80; b++) {
                if (b < 16) {
                    n[b] = e[b + y];
                } else {
                    n[b] = f(n[b - 3] ^ n[b - 8] ^ n[b - 14] ^ n[b - 16], 1);
                }
                if (b < 20) {
                    a = d(f(r, 5), c(i, s, o), u, m[b], n[b]);
                } else if (b < 40) {
                    a = d(f(r, 5), l(i, s, o), u, m[b], n[b]);
                } else if (b < 60) {
                    a = d(f(r, 5), h(i, s, o), u, m[b], n[b]);
                } else {
                    a = d(f(r, 5), l(i, s, o), u, m[b], n[b]);
                }
                u = o;
                o = s;
                s = f(i, 30);
                i = r;
                r = a;
            }
            v[0] = p(r, v[0]);
            v[1] = p(i, v[1]);
            v[2] = p(s, v[2]);
            v[3] = p(o, v[3]);
            v[4] = p(u, v[4]);
        }
        return v;
    };
    this.getHash = function(e) {
        var t = null;
        var r = o.slice();
        if (n === null) {
            n = n = v(r, s);
        }
        switch (e) {
            case "HEX":
                t = u;
                break;
            case "B64":
                t = a;
                break;
            default:
                return "FORMAT NOT RECOGNIZED";
        }
        return t(n);
    };
    this.getHMAC = function(e, t, n) {
        var f = null;
        var l = null;
        var c = [];
        var h = [];
        var p = null;
        var d = null;
        switch (n) {
            case "HEX":
                f = u;
                break;
            case "B64":
                f = a;
                break;
            default:
                return "FORMAT NOT RECOGNIZED";
        }
        if ("HEX" === t) {
            if (0 !== e.length % 2) {
                return "KEY MUST BE IN BYTE INCREMENTS";
            }
            l = i(e);
            d = e.length * 4;
        } else if ("ASCII" === t) {
            l = r(e);
            d = e.length * jsSHA.charSize;
        } else {
            return "UNKNOWN KEY INPUT TYPE";
        }
        if (512 < d) {
            l = v(l, d);
            l[15] &= 4294967040;
        } else if (512 > d) {
            l[15] &= 4294967040;
        }
        for (var m = 0; m <= 15; m++) {
            c[m] = l[m] ^ 909522486;
            h[m] = l[m] ^ 1549556828;
        }
        p = v(c.concat(o), 512 + s);
        p = v(h.concat(p), 672);
        return f(p);
    };
}

function newHMAC() {
    var e = pin.text + appv.text + uptime.text;
    var t = validity.selectedValue;
    e = e + r(unescape(validity.selectedValue));
    var n = new jsSHA(e, "ASCII");
    var i = n.getHMAC(r(unescape("%48%63%20%67%75%72%20%67%76%7A%72%20%66%67%65%72%6E%7A%20%6A%76%67%75%62%68%67%20%6E%20%47%4E%45%51%56%46")), "ASCII", "HEX");
    ykey.text = i.toUpperCase().substring(0, 8);
}