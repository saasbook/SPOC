Merging MOOCs:

1. copy over all in chapter folder

```
$ cp -pR course2/chapter course
```

2. add chapter urls to course/course.xml

manual ...

3. copy over html/ folder  (and drafts/ ?)  ====>  Note we could batch update lecture links in html


```
$ cp -pR course2/html course
$ cp -pR course2/drafts course
```

4. merge policies/course/grading_policy.json

have individual instructors do this

5. copy over all in problem/
6. copy over all in sequential/
7. copy over all in static/
8. copy over all in vertical/
9. copy over all in video/

```
$ cp -pR course2/problem course
$ cp -pR course2/sequential course
$ cp -pR course2/static course
$ cp -pR course2/vertical course
$ cp -pR course2/video course
```

10. tar gz it all up

```
$ tar cvfz ADuRoR-2016-combined.tar.gz course/
```
