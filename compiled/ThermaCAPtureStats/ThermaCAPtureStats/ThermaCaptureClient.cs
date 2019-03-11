using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ThermaCAPtureStats
{
    public class ThermaCaptureClient
    {
        List<FakeResult> _fakeResults;

        public ThermaCaptureClient()
        {
            _fakeResults = new List<FakeResult> {
                new FakeResult {
                    SensorName = "Vance - Temperature Sensor",
                    CurrentTemperature = 75,
                    Status = "HOT"
                },
                new FakeResult {
                    SensorName = "Chris/Luke - Temperature Sensor",
                    CurrentTemperature = 75.6,
                    Status = "n/a"
                },
                new FakeResult {
                    SensorName = "Kurt/Julie - Temperature Sensor",
                    CurrentTemperature = 76.1,
                    Status = "COLD"
                },
                new FakeResult {
                    SensorName = "Dave/Pete - Temperature Sensor",
                    CurrentTemperature = 76.5,
                    Status = "n/a"
                }
            };
        }

        public FakeResult GetStats(string search)
        {
            return _fakeResults.Where(r => r.SensorName.Contains(search, StringComparison.CurrentCultureIgnoreCase)).FirstOrDefault();
        }
    }
}
