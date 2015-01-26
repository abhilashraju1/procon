#!/usr/bin/ruby

require 'net/http'
T=2023636070998557444542586045
M=1267650600228229401496703205376
c=M/2
x=1
while c!=0
	if (T-M-c)%(2*c)==0
		Net::HTTP.start('salvageon.textfile.org'){|http|
			resp=http.get('/?db=2&index='+(x + (x+(T-M-c)/(2*c))).to_s)
			sleep(1)
			redo if resp.code!='200'
			a=resp.body.split
			key=a[2][1..-1].to_i
			raise if key!=T
			puts a[3] # V1101943557675920722238136981003
		}
	end
	x*=2
	c/=2
end

__END__
【問２】
少しAPIを見ると、規則性が見えてくるので、
以下のプログラム(半分全探索)で解ける場合もある。

# --- #
#!/usr/bin/ruby
T=722956982942662080541088546816
M=1267650600228229401496703205376

=begin
h={
	0=>0
}
Net::HTTP.start('salvageon.textfile.org'){|http|
	x=1
	while x<M
		p x
		resp=http.get('/?db=2&index='+x.to_s)
		sleep(1)
		redo if resp.code!='200'
		a=resp.body.split
		key=a[2][1..-1].to_i
		h[x]=key
		x*=2
	end
}
=end

h={
	0=>0,
	1=>633825300114114700748351602688,
	2=>316912650057057350374175801344,
	4=>158456325028528675187087900672,
	8=>79228162514264337593543950336,
	16=>39614081257132168796771975168,
	32=>19807040628566084398385987584,
	64=>9903520314283042199192993792,
	128=>4951760157141521099596496896,
	256=>2475880078570760549798248448,
	512=>1237940039285380274899124224,
	1024=>618970019642690137449562112,
	2048=>309485009821345068724781056,
	4096=>154742504910672534362390528,
	8192=>77371252455336267181195264,
	16384=>38685626227668133590597632,
	32768=>19342813113834066795298816,
	65536=>9671406556917033397649408,
	131072=>4835703278458516698824704,
	262144=>2417851639229258349412352,
	524288=>1208925819614629174706176,
	1048576=>604462909807314587353088,
	2097152=>302231454903657293676544,
	4194304=>151115727451828646838272,
	8388608=>75557863725914323419136,
	16777216=>37778931862957161709568,
	33554432=>18889465931478580854784,
	67108864=>9444732965739290427392,
	134217728=>4722366482869645213696,
	268435456=>2361183241434822606848,
	536870912=>1180591620717411303424,
	1073741824=>590295810358705651712,
	2147483648=>295147905179352825856,
	4294967296=>147573952589676412928,
	8589934592=>73786976294838206464,
	17179869184=>36893488147419103232,
	34359738368=>18446744073709551616,
	68719476736=>9223372036854775808,
	137438953472=>4611686018427387904,
	274877906944=>2305843009213693952,
	549755813888=>1152921504606846976,
	1099511627776=>576460752303423488,
	2199023255552=>288230376151711744,
	4398046511104=>144115188075855872,
	8796093022208=>72057594037927936,
	17592186044416=>36028797018963968,
	35184372088832=>18014398509481984,
	70368744177664=>9007199254740992,
	140737488355328=>4503599627370496,
	281474976710656=>2251799813685248,
	562949953421312=>1125899906842624,
	1125899906842624=>562949953421312,
	2251799813685248=>281474976710656,
	4503599627370496=>140737488355328,
	9007199254740992=>70368744177664,
	18014398509481984=>35184372088832,
	36028797018963968=>17592186044416,
	72057594037927936=>8796093022208,
	144115188075855872=>4398046511104,
	288230376151711744=>2199023255552,
	576460752303423488=>1099511627776,
	1152921504606846976=>549755813888,
	2305843009213693952=>274877906944,
	4611686018427387904=>137438953472,
	9223372036854775808=>68719476736,
	18446744073709551616=>34359738368,
	36893488147419103232=>17179869184,
	73786976294838206464=>8589934592,
	147573952589676412928=>4294967296,
	295147905179352825856=>2147483648,
	590295810358705651712=>1073741824,
	1180591620717411303424=>536870912,
	2361183241434822606848=>268435456,
	4722366482869645213696=>134217728,
	9444732965739290427392=>67108864,
	18889465931478580854784=>33554432,
	37778931862957161709568=>16777216,
	75557863725914323419136=>8388608,
	151115727451828646838272=>4194304,
	302231454903657293676544=>2097152,
	604462909807314587353088=>1048576,
	1208925819614629174706176=>524288,
	2417851639229258349412352=>262144,
	4835703278458516698824704=>131072,
	9671406556917033397649408=>65536,
	19342813113834066795298816=>32768,
	38685626227668133590597632=>16384,
	77371252455336267181195264=>8192,
	154742504910672534362390528=>4096,
	309485009821345068724781056=>2048,
	618970019642690137449562112=>1024,
	1237940039285380274899124224=>512,
	2475880078570760549798248448=>256,
	4951760157141521099596496896=>128,
	9903520314283042199192993792=>64,
	19807040628566084398385987584=>32,
	39614081257132168796771975168=>16,
	79228162514264337593543950336=>8,
	158456325028528675187087900672=>4,
	316912650057057350374175801344=>2,
	633825300114114700748351602688=>1
}

x=1
while x<M
	a=[]
	a[0]=h[x]
	a[1]=a[0]*3
	a[2]=a[1]*2-a[0]
	(3).step(x-1){|i|
		a[i]=a[i-2]+a[i-1]-a[i-3]
	}
	idx=a.index(T)
	if idx
		p idx+x
		break
	end
	x*=2
end
# --- #

しかし、これだとxが大きくなってくると現実的な時間で解くのは難しくなる
(上記のTは求めやすいものに変更してある)。
そこで、各領域ごとに一般項を求める必要がある。
最大インデックスである1267650600228229401496703205376をMとおき、
x=1、c=M/2と置き、以降x*=2、c/=2と動かしていくとする。
すると、インデックスx+idxに対するキーの一般項は、
key(x+idx)==M-c*(2*x-2*idx-1)
となる。
key(x+idx)==Tをidxについて移項すると、
M-c*(2*x-2*idx-1) == T
2*c*idx == -M+2*c*x-c+T
idx == x+(T-M-c)/(2*c)
idxが存在する条件は(T-M-c)%(2*c)==0であり、この時のx + (x+(T-M-c)/(2*c))が求めるインデックスとなる。
この方法であれば、探索回数は100回で良いので、どんな入力に対しても現実的な時間で解を求めることができる。

以下がプログラムです。