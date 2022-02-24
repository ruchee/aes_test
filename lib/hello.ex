defmodule Hello do

  def hello do
    key = "+XziPkXakkuHYaRTpXv6a3rNfZiKncxwmitKUeJCITo="
    str = String.duplicate("x", 3)

    ret = AesTest.encrypt(str, key)
    # ret = "eyJpdiI6IlQwQWlzdGo0OWpma2p4NXNja2RnWWc9PSIsInZhbHVlIjoidWwvTjFnUjRsRzBnR2loNndFL0c5MVZJK0puQ1JnNVlxZ2dPV3VNdHRKbnIvdWR5clU0OXJyOE9EQ2FaK3RBeSIsIm1hYyI6IjAwM2VkODVkM2UwYjRkN2I4MjExMGRjNThjZWFkNzk1ODkzMjQwM2ZhMjRlNDMwZTQzNzJiZWExOTZmM2UzNTciLCJ0YWciOiIifQ=="
    IO.inspect ret
    IO.inspect AesTest.decrypt(ret, key)
  end

end
