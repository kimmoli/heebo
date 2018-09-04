/*
  Copyright 2012 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef _GAMEMAPSET_H_
#define _GAMEMAPSET_H_

#include <QtCore>
#include <QObject>

#include "gamemap.h"

class GameMapSet : public QObject {
  Q_OBJECT
  Q_PROPERTY(int level
             READ level
             NOTIFY levelChanged
             WRITE setLevel)
  Q_PROPERTY(int numLevels
             READ numLevels
             NOTIFY numLevelsChanged)
  Q_PROPERTY(bool onLastLevel
             READ onLastLevel
             NOTIFY onLastLevelChanged)
  Q_PROPERTY(int height READ height NOTIFY heightChanged)
  Q_PROPERTY(int width READ width NOTIFY widthChanged)
  Q_PROPERTY(int nextSaveLevel READ nextSaveLevel NOTIFY nextSaveLevelChanged)
  
public:
  explicit GameMapSet(int mapNumber, int initialLevel,
                      QObject* parent=0);

  void save(const QString& fileName="");
  
  QString fileName() const { return m_fileName; }
  int level() const;
  int mapNumber() const { return m_map; }
  int setLevel(int l);
  int numLevels() const { return m_number; }
  bool onLastLevel() const { return m_level == m_number-1; }
  int height() const { return m_height; }
  int width() const { return m_width; }
  int nextSaveLevel();

  GameMap* newMap(int);
  void removeMap(int);
  void swapMaps(int, int);

  GameMap* map(int l);

  Q_INVOKABLE int storeHighScore(int map, int level, int time);
  Q_INVOKABLE int getHighScore(int map, int level);
  Q_INVOKABLE void writeNewMap(int map);
  Q_INVOKABLE int getMap();
  Q_INVOKABLE void writeOtherSettings(bool penalty, bool particles);
  Q_INVOKABLE bool getPenaltyMode();
  Q_INVOKABLE bool getParticlesMode();
  Q_INVOKABLE int saveCurrentMap();
  Q_INVOKABLE bool doWeHaveSavedMaps();
  Q_INVOKABLE void loadMaps();

public slots:
  QString at(int r, int c) const;
  QString prop(int r, int c) const;
  void set(int r, int c, QString t);
  void setProp(int r, int c, QString t);

signals:
  void levelChanged();
  void heightChanged();
  void widthChanged();
  void quitHeebo();
  void nextSaveLevelChanged();
  void numLevelsChanged();
  void onLastLevelChanged();

private:
  int loadMap(QString filename = "");

  bool OK(int);

  QString m_fileName;
  
  QList<GameMap*> m_maps;

  int m_width, m_height, m_number;
  int m_level; // current level
  int m_map;
  int m_penalty;
  int m_particles;
};

#endif /* _GAMEMAPSET_H_ */
