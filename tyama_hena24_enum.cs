using System;
using System.Linq;
using System.Collections.Generic;
using System.Runtime.InteropServices;

class Hena24{
	[DllImport("c")]
	private extern static double cbrt(double d);

	static private bool is_sq(int n){
		int x=(int)Math.Sqrt(n);
		return x*x==n;
	}
	static private bool is_cb(int n){
		int x=(int)cbrt(n);
		return x*x*x==n;
	}
	static private bool is_multiple(int i,int n){return i%n==0;}
	static private bool is_le(int i,int n){return i<=n;}

	static private IEnumerable<int> generate(){
		int i=1;
		for(;;){
			yield return i;
			i+=1;
		}
	}
	static private IEnumerable<int> drop_prev(
		Func<int,bool> check,IEnumerable<int> _prev
	){
		IEnumerator<int> prev=_prev.GetEnumerator();
		prev.MoveNext();
		int a=prev.Current;
		prev.MoveNext();
		int b=prev.Current;
		for(;;){
			if(!check(b))yield return a;
			a=b;
			prev.MoveNext();
			b=prev.Current;
		}
	}
	static private IEnumerable<int> drop_next(
		Func<int,bool> check,IEnumerable<int> _prev
	){
		IEnumerator<int> prev=_prev.GetEnumerator();
		prev.MoveNext();
		int a=prev.Current;
		prev.MoveNext();
		int b=prev.Current;
		yield return a;
		for(;;){
			if(!check(a))yield return b;
			a=b;
			prev.MoveNext();
			b=prev.Current;
		}
	}
	static private IEnumerable<int> drop_n(
		Func<int,int,bool> check,int n,IEnumerable<int> _prev
	){
		IEnumerator<int> prev=_prev.GetEnumerator();
		int i=0;
		for(;;){
			i++;
			prev.MoveNext();
			int a=prev.Current;
			if(!check(i,n))yield return a;
		}
	}
	static void Main(){
		var f=new Dictionary<char,Func<IEnumerable<int>,IEnumerable<int>>>(){
			{'S',e => drop_next(is_sq,e)},
			{'s',e => drop_prev(is_sq,e)},
			{'C',e => drop_next(is_cb,e)},
			{'c',e => drop_prev(is_cb,e)},
			{'h',e => drop_n(is_le,100,e)},
		};
		for(int i=2;i<10;i++){
			int j=i; //寿命が短いスコープを作ることで、ラムダ式のキャプチャでバグらないようにする。
			f[(char)('0'+j)] = e=>drop_n(is_multiple,j,e);
		}
		string line;
		for(;(line=Console.ReadLine())!=null;){
			bool first=true;
			foreach(int n in line.Aggregate(generate(),(s,e)=>f[e](s)).Take(10)){
				if(!first)Console.Write(',');
				first=false;
				Console.Write(n);
			}
			Console.WriteLine();
		}
	}
}