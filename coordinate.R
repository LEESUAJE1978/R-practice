#coord_flip() x축과 y축의 위치를 바꿀 때 사용
ggplot(data= mpg, mapping = aes(x=class, y=hwy))+
  geom_boxplot()

ggplot(data= mpg, mapping = aes(x=class, y=hwy))+
  geom_boxplot()+
  coord_flip()

#coord_quickmap(), package: map_data, mapproj
#coord_quickmap을 사용하여 지도 보정
nz<- map_data("nz")
ggplot(nz, aes(long, lat, group=group))+
  geom_polygon(fill= "white", color ="black")

ggplot(nz, aes(long, lat, group=group))+
  geom_polygon(fill= "white", color ="black")+
  coord_quickmap()

#coord_map()을 사용할 때는 mapproj 패키지 사요
nz<- map_data("nz")
ggplot(nz, aes(long, lat, group=group))+
  geom_polygon(fill= "white", color ="black")+
  coord_map()


#coord_polar()_piechart로 표현
bar<- ggplot(data=diamonds)+
  geom_bar(
    mapping =aes(x=cut, fill=cut),
    show.legend = FALSE,
    width = 1
    )+
  theme(aspect.ratio = 1)+
  labs(x=NULL,  y = NULL)

bar
bar+coord_flip()
bar+coord_polar()

#geom_abline(), coord_fixed()
#coord_fixed는 x축과 y축을 1:1로 표현할 때 사용
# 일정한 간격으로 만들고 싶으면 scale_x_continuous(breaks = seq()), scale_y_continuous(breaks = seq())
# 분석가 임의대로 하고 싶으면 scale_x_continuous(breaks = c()), scale_y_continuous(breaks = c())
ggplot(data = mpg, mapping = aes(x=cty, y = hwy))+
  geom_point()+
  geom_abline()+
  coord_fixed()

# reference: R for Data Science