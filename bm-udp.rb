# NOTES ON IMPLEMENTATION:
# Cannot bind multiple sockets to the same port, so a socket will have to be initialized at runtime
# PUTs to statsd will start @ u1.send MSG, 0, PORT
# Make sure socket will not time out
# Make sure socket is secure/send only

require 'benchmark'
require 'socket'

u2 = UDPSocket.new
u2.bind("127.0.0.1", 4914)

puts Benchmark.measure { u1 = UDPSocket.new; u1.bind("127.0.0.1", 4913); u1.send "sdionfoisx348943894 oifsx oisfx xoixfxs xfsxoxi xfxoxixx siof sio foi sfiosfio si fiosb ifsio sfoif soifs oisf fuyabfoibdsufb adfi   ifdufuib afiu dsiu udf auidbfia fuaduif jdha fiudsibf iuab fui", 0, "127.0.0.1", 4913; }
puts Benchmark.measure { u2.send "sdionfoisx348943894 oifsx oisfx xoixfxs xfsxoxi xfxoxixx siof sio foi sfiosfio si fiosb ifsio sfoif soifs oisf fuyabfoibdsufb adfi   ifdufuib afiu dsiu udf auidbfia fuaduif jdha fiudsibf iuab fui", 0, "127.0.0.1", 4914;  }

