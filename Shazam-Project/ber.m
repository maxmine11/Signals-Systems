function rate = ber(a, b, N)
  % Returns the BER between two identically-sized vectors containing numbers
  % that are at most print_len bits long.
  %
  % Inputs:
  % a - first vector
  % b - second vector
  % N - maximum number of bits in each entry of a or b
  %
  % Outputs:
  % rate - bit error rate between a and b. To find this, a and b are
  %        represented as lists of bits, the number of indices where
  %        they differ is counted, and this count is divided by the
  %        total number of bits in a or b.

  A = de2bi(a, N);
  B = de2bi(b, N);
  rate = mean(xor(A(:),B(:)));
end