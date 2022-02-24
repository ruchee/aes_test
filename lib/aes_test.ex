defmodule AesTest do
  def encrypt(text, password) do
    key = Base.decode64!(password)
    iv = :crypto.strong_rand_bytes(16)
    value = :crypto.crypto_one_time(:aes_256_cbc, key, iv, pkcs7_pad(text), true)

    iv = Base.encode64(iv)
    value = Base.encode64(value)
    tag = Base.encode64("")
    mac = :hmac |> :crypto.mac(:sha256, key, iv <> value) |> Base.encode16(case: :lower)

    %{iv: iv, value: value, mac: mac, tag: tag}
    |> Jason.encode!()
    |> Base.encode64()
  end

  def decrypt(text_with_iv, password) do
    key = Base.decode64!(password)
    target = Base.decode64!(text_with_iv, mixed: true)

    {:ok, %{"iv" => iv, "value" => value, "mac" => mac, "tag" => tag}} = Jason.decode(target)

    {:ok, iv} = Base.decode64(iv)
    {:ok, value} = Base.decode64(value)

    padded = :crypto.crypto_one_time(:aes_256_cbc, key, iv, value, false)

    pkcs7_unpad(padded)
  end

  defp pkcs7_pad(message) do
    blocksize = 16
    pad = blocksize - rem(byte_size(message), blocksize)
    message <> to_string(List.duplicate(pad, pad))
  end

  defp pkcs7_unpad(message) do
    <<pad>> = binary_part(message, byte_size(message), -1)
    binary_part(message, 0, byte_size(message) - pad)
  end
end
