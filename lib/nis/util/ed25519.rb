require 'openssl'
require 'digest/sha3'
require 'base32'

module Nis::Util
  module Ed25519
    class << self
      def int2byte(i)
        i.chr
      end

      def indexbytes(buf, i)
        buf[i].ord
      end

      def intlist2bytes(l)
        l.map {|c| c.chr }.join
      end

      # standard implement
      def H(m)
        OpenSSL::Digest::SHA512.digest(m)
      end

      def HH(m)
        Digest::SHA3.digest(m)
      end

      def pow2(x, p)
        # """== pow(x, 2**p, q)"""
        while p > 0 do
          x = x * x % $q
          p -= 1
        end
        x
      end

      def inv(z)
        # """$= z^{-1} \mod q$, for z != 0"""
        # Adapted from curve25519_athlon.c in djb's Curve25519.
        z2 = z * z % $q  # 2
        z9 = pow2(z2, 2) * z % $q  # 9
        z11 = z9 * z2 % $q  # 11
        z2_5_0 = (z11 * z11) % $q * z9 % $q  # 31 == 2^5 - 2^0
        z2_10_0 = pow2(z2_5_0, 5) * z2_5_0 % $q  # 2^10 - 2^0
        z2_20_0 = pow2(z2_10_0, 10) * z2_10_0 % $q  # ...
        z2_40_0 = pow2(z2_20_0, 20) * z2_20_0 % $q
        z2_50_0 = pow2(z2_40_0, 10) * z2_10_0 % $q
        z2_100_0 = pow2(z2_50_0, 50) * z2_50_0 % $q
        z2_200_0 = pow2(z2_100_0, 100) * z2_100_0 % $q
        z2_250_0 = pow2(z2_200_0, 50) * z2_50_0 % $q  # 2^250 - 2^0
        pow2(z2_250_0, 5) * z11 % $q  # 2^255 - 2^5 + 11 = q - 2
      end

      def xrecover(y)
        xx = (y * y - 1) * inv($d * y * y + 1)
        x = xx.to_bn.mod_exp(($q + 3) / 8, $q)
        x = (x * $I) % $q if (x * x - xx) % $q != 0
        x = $q - x if x % 2 != 0
        x
      end

      def edwards_add(_P, _Q)
        # This is formula sequence 'addition-add-2008-hwcd-3' from
        # http://www.hyperelliptic.org/EFD/g1p/auto-twisted-extended-1.html
        x1, y1, z1, t1 = _P
        x2, y2, z2, t2 = _Q

        a = (y1 - x1) * (y2 - x2) % $q
        b = (y1 + x1) * (y2 + x2) % $q
        c = t1 * 2 * $d * t2 % $q
        dd = z1 * 2 * z2 % $q
        e = b - a
        f = dd - c
        g = dd + c
        h = b + a
        x3 = e * f
        y3 = g * h
        t3 = e * h
        z3 = f * g

        [x3 % $q, y3 % $q, z3 % $q, t3 % $q]
      end

      def edwards_double(_P)
        # This is formula sequence 'dbl-2008-hwcd' from
        # http://www.hyperelliptic.org/EFD/g1p/auto-twisted-extended-1.html
        x1, y1, z1, _t1 = _P

        a = x1 * x1 % $q
        b = y1 * y1 % $q
        c = 2 * z1 * z1 % $q
        # dd = -a
        e = ((x1 + y1) * (x1 + y1) - a - b) % $q
        g = -a + b  # dd + b
        f = g - c
        h = -a - b  # dd - b
        x3 = e * f
        y3 = g * h
        t3 = e * h
        z3 = f * g

        return x3 % $q, y3 % $q, z3 % $q, t3 % $q
      end

      def scalarmult(_P, e)
        return $ident if e == 0
        _Q = scalarmult(_P, e / 2)
        _Q = edwards_double(_Q)
        _Q = edwards_add(_Q, _P) if e & 1
        _Q
      end

      def make_Bpow
        _P = $B
        (0...253).each do |_|
          $Bpow << _P
          _P = edwards_double(_P)
        end
      end

      # Implements scalarmult(B, e) more efficiently.
      def scalarmult_B(e)
        # scalarmult(B, l) is the identity
        e = e % $l
        _P = $ident
        (0...253).each do |i|
          _P = edwards_add(_P, $Bpow[i]) if e & 1 == 1
          e = e / 2
        end
        _P
      end

      def encodeint(y)
        bits = (0...$b).map {|i| (y >> i) & 1}
        (0...$b/8).map {|i| int2byte((0...8).inject(0) {|sum, j| sum + (bits[i * 8 + j] << j) }) }.join
      end

      def encodepoint(_P)
        x, y, z, _t = _P
        zi = inv(z)
        x = (x * zi) % $q
        y = (y * zi) % $q
        bits = (0...$b-1).map {|i| (y >> i) & 1} + [x & 1]
        (0...$b/8).map {|i| int2byte((0...8).inject(0) {|sum, j| sum + (bits[i * 8 + j] << j) }) }.join
      end

      def bit(h, i)
        (indexbytes(h, i / 8) >> (i % 8)) & 1
      end

      def publickey_unsafe(sk)
        h = H(sk)
        a = 2 ** ($b-2) + (3...$b-2).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
        _A = scalarmult_B(a)
        return encodepoint(_A)
      end

      def publickey_hash_unsafe(sk)
        h = HH(sk)
        a = 2 ** ($b-2) + (3...$b-2).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
        _A = scalarmult_B(a)
        return encodepoint(_A)
      end

      def Hint(m)
        h = H(m)
        (0...2*$b).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
      end

      def Hint_hash(m)
        h = HH(sk)
        (0...2*$b).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
      end

      def signature_unsafe(m, sk, pk)
        h = H(sk)
        a = 2 ** ($b-2) + (3...$b-2).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
        r = Hint(
          intlist2bytes(($b/8...$b/4).map {|j| indexbytes(h, j) }) + m
        )
        _R = scalarmult_B(r)
        _S = (r + Hint(encodepoint(_R) + pk + m) * a) % $l
        encodepoint(_R) + encodeint(_S)
      end

      # Not safe to use with secret keys or secret data.
      #
      # See module docstring.  This function should be used for testing only.
      def signature_hash_unsafe(m, sk, pk)
        h = HH(sk)
        a = 2 ** ($b-2) + (3...$b-2).inject(0) {|sum, i| sum + 2 ** i * bit(h, i) }
        r = Hint_hash(
          intlist2bytes(($b/8...$b/4).map {|j| indexbytes(h, j) }) + m
        )
        _R = scalarmult_B(r)
        _S = (r + Hint_hash(encodepoint(_R) + pk + m) * a) % $l
        encodepoint(_R) + encodeint(_S)
      end

      def isoncurve(_P)
        x, y, z, t = _P
        (z % $q != 0 and
          x * y % $q == z * t % $q and
          (y * y - x * x - z * z - $d * t * t) % $q == 0)
      end

      def decodeint(s)
        (0...$b).inject(0) {|sum, i| sum + 2 ** i * bit(s, i) }
      end

      def decodepoint(s)
        y = (0...$b-1).inject(0) {|sum, i| 2 ** i * bit(s, i) }
        x = xrecover(y)
        x = $q - x if x & 1 != bit(s, $b - 1)
        _P = [x, y, 1, (x * y) % $q]
        raise "decoding point that is not on curve" unless isoncurve(_P)
        _P
      end

      class SignatureMismatch < StandardError
      end

      # Not safe to use when any argument is secret.
      #
      # See module docstring.  This function should be used only for
      # verifying public signatures of public messages.
      def checkvalid(s, m, pk)
        raise "signature length is wrong" if s.size != $b / 4
        raise "public-key length is wrong" if pk.size != $b / 8

        # _R = decodepoint(s[:b // 8])
        _R = decodepoint(s[0...$b/8])
        _A = decodepoint(pk)
        _S = decodeint(s[$b/8...$b/4])
        h = Hint(encodepoint(_R) + pk + m)

        x1, y1, z1, _t1 = _P = scalarmult_B(_S)
        x2, y2, z2, _t2 = _Q = edwards_add(_R, scalarmult(_A, h))

        if (!isoncurve(_P) || !isoncurve(_Q) || (x1 * z2 - x2 * z1) % q != 0 || (y1 * z2 - y2 * z1) % q != 0)
          raise SignatureMismatch("signature does not pass verification")
        end
      end
    end

    $b = 256
    $q = 2 ** 255 - 19
    $l = 2 ** 252 + 27742317777372353535851937790883648493

    $d = -121665 * self.inv(121666) % $q
    $I = 2.to_bn.mod_exp(($q - 1) / 4, $q)

    $By = 4 * self.inv(5)
    $Bx = self.xrecover($By)
    $B = [$Bx % $q, $By % $q, 1, ($Bx * $By) % $q]
    $ident = [0, 1, 1, 0]

    # Bpow[i] == scalarmult(B, 2**i)
    $Bpow = []
    self.make_Bpow
  end
end
