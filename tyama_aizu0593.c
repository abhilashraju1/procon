a[1000],s[1000];
i;main(j,n,m,b){
	for(scanf("%d%d",&n,&m);i<n;i++)scanf("%d",a+i);
	for(i=0;i<m;i++){
		for(scanf("%d",&b),j=0;j<n;j++)if(a[j]<=b)break;
		s[j]++;
	}
	for(j=m=i=0;i<n;i++)if(m<s[i])m=s[i],j=i;
	printf("%d\n",j+1);
}