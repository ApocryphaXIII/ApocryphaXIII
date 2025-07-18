import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SatelliteControl = (props) => {
  const { act, data } = useBackend();
  const satellites = data.satellites || [];
  return (
    <Window width={400} height={305}>
      <Window.Content>
        {data.meteor_shield && (
          <Section>
            <LabeledList>
              <LabeledList.Item label="Coverage">
                <ProgressBar
                  value={
                    data.meteor_shield_coverage /
                    data.meteor_shield_coverage_max
                  }
                  content={
                    (100 * data.meteor_shield_coverage) /
                      data.meteor_shield_coverage_max +
                    '%'
                  }
                  ranges={{
                    good: [1, Infinity],
                    average: [0.3, 1],
                    bad: [-Infinity, 0.3],
                  }}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        <Section title="Satellite Controls">
          <Box mr={-1}>
            {satellites.map((satellite) => (
              <Button.Checkbox
                key={satellite.id}
                checked={satellite.active}
                content={'#' + satellite.id + ' ' + satellite.mode}
                onClick={() =>
                  act('toggle', {
                    id: satellite.id,
                  })
                }
              />
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
