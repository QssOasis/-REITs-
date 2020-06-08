from bs4 import BeautifulSoup
import requests
from parsel import Selector
import pandas as pd
import time
from pandas.core.frame import DataFrame
from fake_useragent import UserAgent
ua = UserAgent()
headers={    
    "User-Agent":ua.ie
}
requests.adapters.DEFAULT_RETRIES = 40

def j_par(url):
    
    wr=requests.get(url,headers=headers,stream=True)    
    sel=Selector(wr.text)
    soup = BeautifulSoup(wr.text, 'lxml')
    oth= soup.find_all(class_="special clearfix")
    oth_2=soup.find_all(class_="des")
    
    '''房源名'''
    h_nam=sel.xpath('//div[@class="content"]/div[@class="wrap pb80"]/ul[@class="fyuan-list"]/li/a/div[@class="des"]/p[@class="tit"]/text()').extract()

    '''房型'''
    h_typ=sel.xpath('//div[@class="content"]/div[@class="wrap pb80"]/ul[@class="fyuan-list"]/li/a/div[@class="des"]/div[@class="room"]/span[1]/text()').extract()
    
    '''面积'''
    h_siz=sel.xpath('//div[@class="content"]/div[@class="wrap pb80"]/ul[@class="fyuan-list"]/li/a/div[@class="des"]/div[@class="room"]/span[2]/text()').extract()
    
    '''楼层'''
    h_flo=sel.xpath('//div[@class="content"]/div[@class="wrap pb80"]/ul[@class="fyuan-list"]/li/a/div[@class="des"]/div[@class="room"]/span[3]/text()').extract()
    
    '''优势'''
    h_sep=[]
    for tag in oth:
        if tag.get_text()=="\n":
            h_sep.append(" ")
        else:
            h_sep.append(tag.get_text().strip().replace('\n','',0).replace('\n',','))
    
    h_tra2=[]
    for tag in oth_2:
        if tag.find(class_="distance"):
            h_tra2.append(tag.find(class_="distance").get_text().replace('\n',''))
        else:
            h_tra2.append(" ")
    
    '''价格'''
    h_pri=sel.xpath('//div[@class="content"]/div[@class="wrap pb80"]/ul[@class="fyuan-list"]/li/a/div[@class="price"]/span[@class="num"]/text()').extract()

    '''房源号'''
    a=soup.find_all("a",class_="clearfix")
    h_cod=[]
    for t in a:
        h_cod.append(t.get('href'))

    '''地址&交通及周边设施'''
    h_add=[]
    h_des=[]
    for c in h_cod:
        ur = "http://zufang.jiwu.com"+c
        wr = requests.get(ur,headers=headers,stream=True)
        wesoup=BeautifulSoup(wr.text,'lxml')
        wesoup_1=wesoup.find_all('td') #用于地址
        wesoup_2=wesoup.find('p',class_='fwms').get_text()  #用于设施

        ''' 地址 '''
        td_content=[]
        for i in wesoup_1:
            td_content.append(i.text)
        length=len(wesoup_1)
        wetd=td_content[length-1]#筛选地址
        h_add.append(wetd)

        '''交通及周边设施'''
        wesoup_2_des=wesoup_2
        h_des.append(wesoup_2_des)
        
    #将列表转换成字典       
    c={"h_cod" : h_cod,
       "h_nam" : h_nam,       
       "h_loc" : h_add,       
       "h_typ" : h_typ,
       "h_siz" : h_siz,
       "h_pri" : h_pri,
       "h_flo" : h_flo,
       "h_sep" : h_sep,
       "h_des" : h_des}
    
    #将字典转换成为数据框
    pages_info=DataFrame(c)
   
    return pages_info

def pp(pages):    
    count=0    
    for page in pages:
        a=j_par(page)
        count=count+1
        print ('the '+str(count)+' page is sucessful')
        time.sleep(5)        
        l=pd.DataFrame(columns=['h_cod','h_nam','h_loc','h_typ','h_siz','h_flo','h_pri','h_sep','h_des'])
        l=pd.concat([l,a],ignore_index=True)    
    return l

for p in range(1,8):
    pages=[]
    if p==1:
        pages.append('http://zufang.jiwu.com/gz/gongyu46/')
    else:
        pages.append('http://zufang.jiwu.com/gz/gongyu46/page'+str(p)+'/')
        
    lj=pp(pages)
    lj.to_csv('d:\\boyu_gz_futian_10__'+str(p)+'.csv')