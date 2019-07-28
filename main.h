#ifndef MAIN_H
#include <QObject>
#define MAIN_H

class SData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int width READ getWidth WRITE setWidth)
    Q_PROPERTY(int height READ getHeight WRITE setHeight)
public:
    int getWidth(){
        return width;
    }
    void setWidth(int w){
        width = w;
    }

    int getHeight(){
        return height;
    }

    void setHeight(int h){
        height = h;
    }
private:
    int width;
    int height;

};


#endif // MAIN_H
