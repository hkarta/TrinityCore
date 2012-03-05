#ifndef ALLOWEDAREAS_H
#define ALLOWEDAREAS_H

extern WorldDatabaseWorkerPool WorldDatabase;

class LastPosition
{
public:
	LastPosition(void);
	LastPosition(int, float, float, float, float);
	int map_id;
	float x, y, z, o;
};

class AllowedArea
{
public:
	AllowedArea(int, float, float, float, int);
	bool IsWithinArea(Player *p);
private:
	int map_id, distance;
	float x, y, z;
};

typedef std::list<AllowedArea *> AllowedAreasList;

class AllowedAreas
{
public:
	AllowedAreas(void);
	~AllowedAreas(void);
	int LoadAreas(void);
	bool HasAccessToArea(Player *p);
private:
	AllowedAreasList allowedAreas;
};

extern AllowedAreas AllowedAreasMgr;

#endif
