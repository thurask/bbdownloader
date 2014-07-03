#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>

/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT

public:
    ApplicationUI();
    virtual ~ApplicationUI() {}

private slots:

private:
};

#endif /* ApplicationUI_HPP_ */
