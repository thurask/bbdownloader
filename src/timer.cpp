#include <QTimer>
#include "timer.hpp"

Timer::Timer(QObject* parent)
     : bb::cascades::CustomControl(),
     _timer(new QTimer(this))
{
    Q_UNUSED(parent);
    connect(_timer, SIGNAL(timeout()), this, SIGNAL(timeout()));
    setVisible(false);
}

bool Timer::isActive()
{
    return _timer->isActive();
}

int Timer::interval()
{
    return _timer->interval();
}

void Timer::setInterval(int m_sec)
{
    // If the timer already has the specified interval, do nothing
    if (_timer->interval() == m_sec)
        return;

    // Otherwise, set the interval of the timer and emit the
    // intervalChanged() signal
    _timer->setInterval(m_sec);
    emit intervalChanged();
}

void Timer::start()
{
    // If the timer has already been started, do nothing
    if (_timer->isActive())
        return;

    // Otherwise, start the timer and emit the activeChanged()
    // signal
    _timer->start();
    emit activeChanged();
}

void Timer::stop()
{
    // If the timer has already been stopped, do nothing
    if (!_timer->isActive())
        return;

    // Otherwise, stop the timer and emit the activeChanged()
    // signal
    _timer->stop();
    emit activeChanged();
}
